//
//  Header.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 02.02.26.
//

import SwiftUI
import HerpiUI
import HerpiFoundation

struct Header: View {
    var currentLocation: String
    var menuAction: () -> Void
    var pickLocationAction: () -> Void
    var chatAction: () -> Void
    var typeOfHeader: TypeOfHeader = .other
    
    enum TypeOfHeader {
        case main
        case other
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            MenuButton { menuAction() }
            Spacer()
            
            switch typeOfHeader {
            case .main:
                MainTypeHeader(currentLocation: currentLocation, pickLocationAction: pickLocationAction)
                
            case .other:
                OtherTypeHeader()
            }
            
            Spacer()
            ChatButton { chatAction() }
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.vertical, Constants.verticalPadding)
        .background(HerpiColor.tint)
    }
    
    struct Constants {
        static let horizontalPadding: CGFloat = 20
        static let verticalPadding: CGFloat = 15
    }
}

#Preview {
    Header(
        currentLocation: .empty,
        menuAction: { },
        pickLocationAction: { },
        chatAction: { }
    )
}
