//
//  ChooseLocationSheetFooter.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 28.02.26.
//

import SwiftUI
import HerpiUI

extension ChooseLocationSheet {
    struct Footer: View {
        var currentLocationString: String
        var cancelAction: () -> Void
        var completeAction: () -> Void
        
        var body: some View {
            VStack(spacing: Constants.vstackSpacing) {
                Text(currentLocationString)
                    .font(HerpiFont.bold_16)
                    .foregroundStyle(HerpiColor.Title.primary)
                
                HStack(spacing: Constants.buttonsSpacing) {
                    Button {
                        cancelAction()
                    } label: {
                        Text(L.ChooseLocation.cancel)
                            .font(HerpiFont.semibold_16)
                            .foregroundStyle(HerpiColor.VenomType.venomous)
                            .frame(height: Constants.buttonHeight)
                            .padding(.horizontal)
                    }
                    
                    Button {
                        completeAction()
                    } label: {
                        Text(L.ChooseLocation.complete)
                            .font(HerpiFont.semibold_16)
                            .foregroundStyle(HerpiColor.white)
                            .frame(height: Constants.buttonHeight)
                            .padding(.horizontal)
                            .background(HerpiColor.tint)
                            .clipShape(.capsule)
                    }
                }
            }
        }
        
        struct Constants {
            static let buttonsSpacing: CGFloat = 50
            static let buttonHeight: CGFloat = 50
            static let vstackSpacing: CGFloat = 20
        }
    }
}
