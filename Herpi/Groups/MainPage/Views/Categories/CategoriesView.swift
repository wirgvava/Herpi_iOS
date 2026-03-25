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
    var onScrollingChanged: ((Bool) -> Void)? = nil
    
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
        .simultaneousGesture(
            DragGesture(minimumDistance: Constants.dragGestureMinimumDistance)
                .onChanged { value in
                    let isHorizontal = abs(value.translation.width) > abs(value.translation.height)
                    if isHorizontal {
                        onScrollingChanged?(true)
                    }
                }
                .onEnded { _ in
                    onScrollingChanged?(false)
                }
        )
    }
    
    struct Constants {
        static let spacing: CGFloat = 24
        static let dragGestureMinimumDistance: CGFloat = 5
    }
}

#Preview {
    CategoriesView(
        selectedCategory: mockCategories.first!.titleTurned,
        categories: mockCategories,
        onCategorySelected: { _ in }
    )
}
