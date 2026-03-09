//
//  DetailPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import HerpiModels
import ComposableArchitecture

@Reducer
struct DetailPageFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        let reptileId: Int
        var detailedInfo: DetailedInfoModel = mockDetailedInfo
        var coverage: CoverageModel = mockCoverage
        var isLoading: Bool = false
        var showGallery: Bool = false
        var selectedPhotoIndex: Int = .zero
    }
    
    // MARK: - Action
    enum Action {
        case push(NavigationFeature.Path.State)
        case didFailWithError(String)
        
        case didTapOnShare
        case didTapOnExpandMap
        case didTapOnPhoto(Int)
        case dismissGallery
    }
    
    // MARK: - Body
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .push:
                return .none
                
            case .didFailWithError:
                // Handled by parent (NavigationFeature -> AppFeature)
                return .none
                
            case .didTapOnShare:
                let reptileId = state.reptileId
                return .run { _ in
                    await shareReptile(reptileId: reptileId)
                }
                
            case .didTapOnExpandMap:
                return .send(.push(.map(.init(coverage: state.coverage))))
                
            case .didTapOnPhoto(let photoId):
                if let index = state.detailedInfo.gallery.firstIndex(where: { $0.id == photoId }) {
                    state.selectedPhotoIndex = index
                }
                withAnimation {
                    state.showGallery = true
                }
                return .none
                
            case .dismissGallery:
                withAnimation {
                    state.showGallery = false
                }
                return .none
            }
        }
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
        
        AppAnalytics.logEvents(with: .share, paramName: .specie_id, paramData: reptileId)
        
        topController.present(activityVC, animated: true)
    }
}
