//
//  BackButton.swift
//  HerpiUI
//
//  Created by Konstantine Tsirgvava on 18.01.26.
//

import SwiftUI
import HerpiFoundation

public struct BackButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    public var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(.backArrow)
                .resizable()
                .aspectRatio(.one, contentMode: .fit)
                .frame(width: Constants.width)
                .foregroundColor(HerpiColor.white)
            
        }
    }
    
    struct Constants {
        static let width: CGFloat = 25
    }
}

#Preview {
    BackButton()
        .background(.black)
}
