//
//  CategoryCard.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 22.01.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import HerpiFoundation

struct CategoryCard: View {
    var isSelected: Bool
    var category: CategoryModel
    
    var body: some View {
        VStack(spacing: Constants.verticalSpacing) {
            RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
                .fill(isSelected ? HerpiColor.tint : HerpiColor.white)
                .frame(width: Constants.cardWidth, height: Constants.cardHeight)
                .overlay {
                    CachedAsyncImage(url: category.iconUrl, placeholder: { }, renderingMode: .template)
                        .aspectRatio(.one, contentMode: .fit)
                        .frame(width: Constants.imageWidth)
                        .foregroundStyle(isSelected ? HerpiColor.white : HerpiColor.dark)
                }
            
            Text(category.titleTurned)
                .foregroundStyle(HerpiColor.Title.primary)
                .font(HerpiFont.semibold_14)
        }
    }
    
    struct Constants {
        static let verticalSpacing: CGFloat = 12
        static let cardCornerRadius: CGFloat = 12
        static let imageWidth: CGFloat = 50
        static let cardHeight: CGFloat = 90
        @MainActor static let cardWidth: CGFloat = (
            UIScreen.main.bounds.size.width - (
                (2 * CategoriesView.Constants.spacing) +
                (2 * MainPageView.Constants.viewPadding)
            )
        ) / 3
    }
}

#Preview {
    CategoryCard(
        isSelected: true,
        category: mockCategories.first!
    )
}
