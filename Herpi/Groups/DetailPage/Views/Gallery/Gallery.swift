//
//  Gallery.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import Kingfisher

extension DetailPageView {
    struct Gallery: View {
        var info: DetailedInfoModel
        var isLoading: Bool
        var tapped: (Int) -> Void
        
        var body: some View {
            VStack(alignment: .leading, spacing: Constants.vstackSpacing) {
                Text(L.DetailPage.gallery)
                    .font(HerpiFont.semibold_16)
                    .foregroundStyle(HerpiColor.Title.primary)
                    .skeleton(isLoading: isLoading)
                
                ScrollView(.horizontal) {
                    LazyHGrid(
                        rows: Array(
                            repeating: GridItem(spacing: .zero),
                            count: Constants.rowsCount
                        ),
                        spacing: .zero
                    ) {
                        ForEach(info.gallery, id: \.id) { photo in
                            ZStack(alignment: .bottomLeading) {
                                KFImage(photo.url.asURL())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: Constants.imageWidth,
                                        height: Constants.imageHeight
                                    )
                                    .clipped()
                                
                                LinearGradient(
                                    colors: [Constants.gradientInitialColor, .clear],
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                                
                                Text(L.DetailPage.creditsTo(photo.author.fullName))
                                    .font(HerpiFont.semibold_10)
                                    .foregroundStyle(HerpiColor.white)
                                    .padding(Constants.authorTextPadding)
                            }
                            .cornerRadius(Constants.cardCornerRadius)
                            .skeleton(isLoading: isLoading)
                            .padding(.trailing, Constants.cardPadding)
                            .padding(.bottom, Constants.cardPadding)
                            .onTapGesture {
                                guard !isLoading else { return }
                                tapped(photo.id)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        
        struct Constants {
            static let vstackSpacing: CGFloat = 12
            static let rowsCount: Int = 2
            static let imageWidth: CGFloat = 220
            static let imageHeight: CGFloat = 120
            static let gradientInitialColor: Color = .black.opacity(0.8)
            static let authorTextPadding: CGFloat = 15
            static let cardCornerRadius: CGFloat = 16
            static let cardPadding: CGFloat = 16
        }
    }
}
