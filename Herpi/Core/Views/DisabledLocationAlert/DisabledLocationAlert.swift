//
//  DisabledLocationAlert.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 03.03.26.
//

import SwiftUI
import HerpiUI

struct DisabledLocationAlert: View {
    
    @Environment(\.presentationMode) private var presentationMode
    var openSettingsAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: Constants.vstackSpacing) {
                image
                titles
                buttons
            }
            .padding(Constants.padding)
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
    
    // Image
    var image: some View {
        Image(.locationSlash)
            .resizable()
            .aspectRatio(.one, contentMode: .fit)
            .frame(height: Constants.imageHeight)
            .foregroundStyle(HerpiColor.VenomType.venomous)
    }
    
    // Title and description
    var titles: some View {
        VStack(spacing: Constants.textsVerticalSpacing) {
            Text(L.DisabledLocation.header)
                .font(HerpiFont.semibold_15)
                .foregroundStyle(HerpiColor.Title.primary)
            
            Text(L.DisabledLocation.description)
                .font(HerpiFont.regular_12)
                .foregroundStyle(HerpiColor.Title.secondary)
        }
    }
    
    // Buttons
    var buttons: some View {
        HStack(spacing: Constants.buttonsSpacing) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text(L.DisabledLocation.ok)
                    .font(HerpiFont.semibold_16)
                    .foregroundStyle(HerpiColor.tint)
                    .frame(height: Constants.buttonHeight)
                    .padding(.horizontal)
            }
            
            Button {
                openSettingsAction()
            } label: {
                Text(L.DisabledLocation.settings)
                    .font(HerpiFont.semibold_16)
                    .foregroundStyle(HerpiColor.white)
                    .frame(height: Constants.buttonHeight)
                    .padding(.horizontal)
                    .background(HerpiColor.tint)
                    .clipShape(.capsule)
            }
        }
    }
    
    struct Constants {
        static let vstackSpacing: CGFloat = 30
        static let textsVerticalSpacing: CGFloat = 4
        static let imageHeight: CGFloat = 90
        static let buttonsSpacing: CGFloat = 20
        static let buttonHeight: CGFloat = 50
        static let padding: CGFloat = 30
    }
}

#Preview {
    DisabledLocationAlert(openSettingsAction: { })
}
