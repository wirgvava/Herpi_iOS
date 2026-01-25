//
//  CategoriesView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 22.01.26.
//

import SwiftUI
import HerpiModels

struct CategoriesView: View {
    var selectedCategory: String
    var categories: CategoriesModel
    var onCategorySelected: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem()], spacing: .zero) {
                ForEach(categories) { category in
                    CategoryCard(
                        isSelected: selectedCategory == category.titleTurned,
                        category: category
                    )
                    .padding(.trailing, Constants.spacing)
                    .onTapGesture {
                        withAnimation {
                            onCategorySelected(category.titleTurned)
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    struct Constants {
        static let spacing: CGFloat = 24
    }
}

#Preview {
    CategoriesView(
        selectedCategory: mockCategories.first!.titleTurned,
        categories: mockCategories,
        onCategorySelected: { _ in }
    )
}
