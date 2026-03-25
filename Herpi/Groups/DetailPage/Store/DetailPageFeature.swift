//
//  DetailPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import StoreKit
import HerpiModels
import HerpiFoundation
import ComposableArchitecture

@Reducer
struct DetailPageFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        let reptileId: Int
        var detailedInfo: DetailedInfoModel = mockDetailedInfo /// default data for skeleton animation
        var coverage: CoverageModel = mockCoverage /// default data for skeleton animation
        var isLoading: Bool = false
        var showGallery: Bool = false
        var selectedPhotoIndex: Int = .zero
    }
    
    // MARK: - Action
    enum Action {
        case push(NavigationFeature.Path.State)
        case onAppear
        case didReceivedDetailedInfo(DetailedInfoModel)
        case didReceivedCoverage(CoverageModel)
        case didFailWithError(String)
        case requestReviewIfNeeded
        
        case didTapOnShare
        case didTapOnExpandMap
        case didTapOnPhoto(Int)
        case dismissGallery
        case didEndedDragGesture(value: DragGesture.Value)
    }
    
    // MARK: - Dependencies
    @Dependency(\.apiClient) var apiClient
    @Dependency(\.dismiss) var dismiss
    
    // MARK: - Body
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .push, .didFailWithError:
                return .none
                
            case .onAppear:
                let id = state.reptileId
                state.isLoading = true
                
                return .run { send in
                    let detailedInfo = try await apiClient.fetchDetailedInfo(reptileId: id)
                    await send(.didReceivedDetailedInfo(detailedInfo))
                    
                    let coverage = try await apiClient.fetchCoverage(reptileId: id)
                    await send(.didReceivedCoverage(coverage))
                } catch: { error, send in
                    await send(.didFailWithError(error.localizedDescription))
                }
                
            case .didReceivedDetailedInfo(let detailedInfo):
                state.isLoading = false
                state.detailedInfo = detailedInfo
                return .send(.requestReviewIfNeeded)
                
            case .didReceivedCoverage(let coverage):
                state.coverage = coverage
                return .none
                
            case .requestReviewIfNeeded:
                return .run { _ in
                    await requestStoreReviewIfNeeded()
                }
                
            case .didTapOnShare:
                let reptileId = state.reptileId
                return .run { _ in
                    await shareReptile(reptileId: reptileId)
                }
                
            case .didTapOnExpandMap:
                AppAnalytics.log(AppAnalytics.Interaction.expandedDistributionMap(specieId: state.reptileId))
                
                let coverage = state.coverage
                return .run { send in
                    await HapticsManager.light.vibrate()
                    await send(.push(.map(.init(coverage: coverage))))
                }
                
            case .didTapOnPhoto(let photoId):
                if let index = state.detailedInfo.gallery.firstIndex(where: { $0.id == photoId }) {
                    state.selectedPhotoIndex = index
                }
                withAnimation {
                    state.showGallery = true
                }
                return .run { _ in
                    await HapticsManager.light.vibrate()
                }
                
            case .dismissGallery:
                withAnimation {
                    state.showGallery = false
                }
                return .run { _ in
                    await HapticsManager.light.vibrate()
                }
                
            case .didEndedDragGesture(let value):
                return .run { _ in
                    let horizontalDistance = value.translation.width
                    let verticalDistance = abs(value.translation.height)
                    
                    // Check if swipe started from left edge and is mostly horizontal
                    if value.startLocation.x < 50 &&
                        horizontalDistance > 80 &&
                        horizontalDistance > verticalDistance * 1.5 {
                        await dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: - Store Review
    private static let reviewThreshold = 3
    
    @MainActor
    private func requestStoreReviewIfNeeded() {
        let manager = UserDefaultsManager.shared
        
        // Don't request if already requested
        guard !manager.getBool(forKey: .hasRequestedReview) else { return }
        
        // Increment view count
        let currentCount = manager.getInt(forKey: .detailPageViewCount) + 1
        manager.set(currentCount, forKey: .detailPageViewCount)
        
        // Request review after threshold views
        guard currentCount >= Self.reviewThreshold else { return }
        
        // Request review
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        
        SKStoreReviewController.requestReview(in: windowScene)
        manager.set(true, forKey: .hasRequestedReview)
    }
    
    // MARK: - Share Action
    @MainActor
    private func shareReptile(reptileId: Int) {
        guard let url = URL(string: AppConstants.shareURL(for: reptileId)) else { return }
        
        let objectsToShare: [Any] = [url]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [.airDrop, .addToReadingList]
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        // Find the topmost presented view controller
        var topController = rootViewController
        while let presented = topController.presentedViewController {
            topController = presented
        }
        
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = topController.view
            popover.sourceRect = CGRect(
                x: topController.view.bounds.midX,
                y: topController.view.bounds.midY,
                width: .zero,
                height: .zero
            )
            popover.permittedArrowDirections = []
        }
        
        AppAnalytics.log(AppAnalytics.Interaction.shared(specieId: reptileId))
        
        topController.present(activityVC, animated: true)
    }
}
