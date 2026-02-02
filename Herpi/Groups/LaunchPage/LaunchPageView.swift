//
//  LaunchPageView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 31.01.26.
//

import SwiftUI
import HerpiUI

struct LaunchPageView: View {
    
    var body: some View {
        ZStack {
            HerpiColor.tint
            
            Image(.logo)
                .resizable()
                .aspectRatio(.one, contentMode: .fit)
                .frame(width: Constants.imageWidth)
            
            ProgressView()
                .colorScheme(.dark)
                .controlSize(.large)
                .padding(.top, Constants.progressViewTopPadding)
        }
        .ignoresSafeArea()
    }
    
    struct Constants {
        static let imageWidth: CGFloat = 150
        static let progressViewTopPadding: CGFloat = 500
    }
}

#Preview {
    LaunchPageView()
}
