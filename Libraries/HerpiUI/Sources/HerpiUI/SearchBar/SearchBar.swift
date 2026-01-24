//
//  SearchBar.swift
//  HerpiUI
//
//  Created by Konstantine Tsirgvava on 14.01.26.
//

import SwiftUI
import HerpiFoundation

public struct SearchBar: View {
    
    @Binding var searchText: String
    var placeholder: String
    var viewType: ViewType = .field
    
    public enum ViewType {
        case button
        case field
    }
    
    public init(
        viewType: ViewType = .field,
        placeholder: String,
        searchText: Binding<String> = .constant(.empty)
    ) {
        self.viewType = viewType
        self.placeholder = placeholder
        self._searchText = searchText
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(HerpiColor.white)
            .frame(height: Constants.height)
            .overlay {
                HStack(spacing: Constants.spacing) {
                    Image(.search)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(HerpiColor.gray)
                        .frame(width: Constants.imageSize, height: Constants.imageSize)
                    
                    switch viewType {
                    case .button:
                        Text(placeholder)
                            .font(HerpiFont.regular_18)
                            .foregroundStyle(HerpiColor.gray)
                        
                    case .field:
                        ZStack(alignment: .leading) {
                            if searchText.isEmpty {
                                Text(placeholder)
                                    .font(HerpiFont.regular_18)
                                    .foregroundStyle(HerpiColor.gray)
                            }
                            TextField(String.empty, text: $searchText)
                                .font(HerpiFont.regular_18)
                                .foregroundStyle(HerpiColor.Title.primary)
                                .tint(HerpiColor.Title.green)
                        }
                    }
                    
                    
                    Spacer()
                }
                .padding(.leading, Constants.leading)
            }
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 25
        static let height: CGFloat = 50
        static let spacing: CGFloat = 20
        static let imageSize: CGFloat = 26
        static let leading: CGFloat = 15
    }
}

#Preview {
    VStack {
        Spacer()
        SearchBar(placeholder: "Search here...")
        Spacer()
    }
    .background(.black)
}
