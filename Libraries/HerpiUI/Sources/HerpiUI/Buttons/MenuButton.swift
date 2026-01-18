//
//  MenuButton.swift
//  HerpiUI
//
//  Created by Konstantine Tsirgvava on 18.01.26.
//

import SwiftUI
import HerpiFoundation

public struct MenuButton: View {
    
    var action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            Image(.menu)
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
    MenuButton(action: { })
        .background(.black)
}
