//
//  NavBar.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import HerpiUI

extension DetailPageView {
    struct NavBar: View {
        var shareAction: () -> Void
        
        var body: some View {
            VStack {
                HStack {
                    BackButton()
                    Spacer()
                    ShareButton { shareAction() }
                }
                
                Spacer()
            }
            .shadow(radius: Constants.shadowRadius)
        }
        
        struct Constants {
            static let shadowRadius: CGFloat = 10
            static let shareButtonWidth: CGFloat = 25
        }
    }
}
