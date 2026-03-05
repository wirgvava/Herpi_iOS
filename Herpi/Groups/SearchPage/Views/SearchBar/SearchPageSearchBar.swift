//
//  SearchPageSearchBar.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 05.03.26.
//

import SwiftUI
import HerpiUI

extension SearchPageView {
    struct SearchPageSearchBar: View {
        @Binding var searchText: String
        
        var body: some View {
            HStack(spacing: Constants.searchBarSpacing) {
                BackButton()
                SearchBar(placeholder: L.SearchBar.placeholder, searchText: $searchText)
            }
            .padding(.vertical, Constants.searchBarVerticalPadding)
            .padding(.horizontal, Constants.searchBarHorizontalPadding)
        }
        
        struct Constants {
            static let searchBarSpacing: CGFloat = 25
            static let searchBarVerticalPadding: CGFloat = 35
            static let searchBarHorizontalPadding: CGFloat = 30
        }
    }
}
