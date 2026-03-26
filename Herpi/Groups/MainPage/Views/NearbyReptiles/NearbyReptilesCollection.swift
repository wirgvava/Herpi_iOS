//
//  NearbyReptilesCollection.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 24.01.26.
//

import SwiftUI
import HerpiUI
import HerpiModels

struct NearbyReptilesCollection: View {
    
    var reptiles: NearbyReptilesModel
    var currentPage: Int
    var isLoading: Bool
    var pageChanged: (Int) -> Void
    var cardTapped: (Int) -> Void
    var onScrollingChanged: ((Bool) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: .zero) {
            ScrollView(.horizontal) {
                LazyHGrid(
                    rows: Array(repeating: GridItem(spacing: .zero), count: Constants.rowsCount),
                    spacing: .zero
                ) {
                    ForEach(Array(reptiles.enumerated()), id: \.element.id) { index, reptile in
                        NearbyReptileCard(reptile: reptile, isLoading: isLoading)
                            .padding(.trailing, Constants.gridSpacing)
                            .padding(.bottom, Constants.gridSpacing)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear.preference(
                                        key: ViewOffsetKey.self,
                                        value: [index: geometry.frame(in: .named(Constants.namedRef)).minX]
                                    )
                                }
                            )
                            .onTapGesture {
                                guard !isLoading else { return }
                                cardTapped(reptile.id)
                            }
                    }
                }
            }
            .coordinateSpace(name: Constants.namedRef)
            .scrollIndicators(.hidden)
            .onPreferenceChange(ViewOffsetKey.self) { positions in
                updateCurrentPage(positions: positions)
            }
            .scrollDetector(onScrollingChanged: onScrollingChanged)
            
            PageControll(
                pageCount: totalPages,
                selectedPage: currentPage
            )
            .skeleton(isLoading: isLoading)
        }
    }
    
    // MARK: - Helper
    private var totalPages: Int {
        max(1, Int(ceil(Double(reptiles.count) / Double(Constants.itemsPerPage))))
    }
    
    private func updateCurrentPage(positions: [Int: CGFloat]) {
        // Find the leftmost visible card (closest to 0 or just past it)
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let visibleCards = positions.filter { $0.value >= -50 && $0.value <= screenWidth }
        
        guard let firstVisibleIndex = visibleCards.keys.min() else { return }
        
        // Calculate which page this card belongs to
        let page = firstVisibleIndex / Constants.itemsPerPage
        let clampedPage = max(0, min(page, totalPages - 1))
        
        if clampedPage != currentPage {
            pageChanged(clampedPage)
        }
    }
    
    struct Constants {
        static let rowsCount: Int = 2
        static let gridSpacing: CGFloat = 24
        static let itemsPerPage: Int = Constants.rowsCount * 2
        static let namedRef: String = "scroll"
        
        @MainActor static let pageWidth: CGFloat =  (Constants.cardWidth + Constants.gridSpacing) * 2
        @MainActor static let cardWidth: CGFloat = (
            UIScreen.main.bounds.size.width - (
                Constants.gridSpacing +
                (2 * MainPageView.Constants.viewPadding)
            )
        ) / 2
    }
}

// MARK: - Scroll Detector
private extension View {
    @ViewBuilder
    func scrollDetector(onScrollingChanged: ((Bool) -> Void)?) -> some View {
        if #available(iOS 18.0, *) {
            self.onScrollPhaseChange { _, newPhase in
                switch newPhase {
                case .interacting, .tracking, .decelerating, .animating:
                    onScrollingChanged?(true)
                case .idle:
                    onScrollingChanged?(false)
                }
            }
        } else {
            self.background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geometry.frame(in: .global).minX
                        )
                }
            )
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { _ in
                onScrollingChanged?(true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    onScrollingChanged?(false)
                }
            }
        }
    }
}
