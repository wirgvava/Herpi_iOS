//
//  ErrorAlert.swift
//  HerpiUI
//
//  Created by Konstantine Tsirgvava on 09.03.26.
//

import SwiftUI

public struct ErrorAlert: View {
    var title: String
    var isPresented: Bool
    
    public init(title: String, isPresented: Bool = true) {
        self.title = title
        self.isPresented = isPresented
    }
    
    public var body: some View {
        VStack {
            Spacer()
            Text(title)
                .font(HerpiFont.semibold_14)
                .foregroundStyle(HerpiColor.white)
                .padding()
                .background(HerpiColor.VenomType.venomous)
                .cornerRadius(Constants.cornerRadius)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .offset(y: isPresented ? .zero : Constants.offsetWhenNotPresented)
        .animation(.spring(duration: Constants.animationDuration, bounce: Constants.animationBounce), value: isPresented)
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 10
        static let offsetWhenNotPresented: CGFloat = 150
        static let animationDuration: Double = 0.5
        static let animationBounce: CGFloat = 0.3
    }
}

#Preview {
    ErrorAlert(title: "An error occured", isPresented: true)
}
