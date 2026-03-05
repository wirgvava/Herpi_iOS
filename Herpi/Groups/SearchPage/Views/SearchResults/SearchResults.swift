//
//  SearchResults.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 05.03.26.
//

import SwiftUI
import HerpiUI
import HerpiModels

extension SearchPageView {
    struct SearchResults: View {
        var data: [SearchedData]
        var isLoading: Bool
        var didTappedOnCard: (Int) -> Void
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(L.SearchBar.results)
                            .font(HerpiFont.bold_16)
                            .foregroundStyle(HerpiColor.Title.primary)
                            .frame(height: Constants.resultsHeaderHeight)
                        
                        Spacer()
                    }
                    
                    ForEach(isLoading ? mockSearchedData : data) { reptile in
                        SearchResultCard(reptile: reptile)
                            .skeleton(isLoading: isLoading)
                            .onTapGesture {
                                didTappedOnCard(reptile.id)
                            }
                    }
                }
                .padding(.horizontal, Constants.resultsHorizontalPadding)
            }
            .background(HerpiColor.background)
            .topCornerRadius(Constants.resultsViewCornerRadius)
            .ignoresSafeArea()
        }
        
        // MARK: - Constants
        struct Constants {
            static let resultsHeaderHeight: CGFloat = 60
            static let resultsHorizontalPadding: CGFloat = 30
            static let resultsViewCornerRadius: CGFloat = 32
        }
    }
}
