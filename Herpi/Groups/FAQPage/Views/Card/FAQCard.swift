//
//  FAQCard.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 13.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels

struct FAQCard: View {
    
    let faq: FAQModelElement
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(spacing: Constants.vstackSpacing) {
            HStack(alignment: .top) {
                Text(faq.question)
                    .font(HerpiFont.bold_14)
                    .foregroundStyle(isExpanded ? HerpiColor.white : HerpiColor.Title.primary)
                
                Spacer()
                
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundStyle(isExpanded ? HerpiColor.white : HerpiColor.dark)
            }
            
            if isExpanded {
                HStack {
                    Text(faq.answer)
                        .font(HerpiFont.regular_12)
                        .foregroundStyle(HerpiColor.white)
                    
                    Spacer()
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.horizontal, Constants.cardHorizontalPadding)
        .padding(.vertical, Constants.cardVerticalPadding)
        .background(isExpanded ? HerpiColor.tint : HerpiColor.white)
        .cornerRadius(Constants.cardCornerRadius)
        .onTapGesture {
            withAnimation(.snappy) {
                isExpanded.toggle()
            }
        }
    }
    
    struct Constants {
        static let vstackSpacing: CGFloat = 12
        static let cardHorizontalPadding: CGFloat = 15
        static let cardVerticalPadding: CGFloat = 20
        static let cardCornerRadius: CGFloat = 16
    }
}
