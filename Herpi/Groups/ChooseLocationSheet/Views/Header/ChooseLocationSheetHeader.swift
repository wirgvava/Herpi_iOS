//
//  ChooseLocationSheetHeader.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 28.02.26.
//

import SwiftUI
import HerpiUI

extension ChooseLocationSheet {
    struct Header: View {
        var body: some View {
            VStack(alignment: .leading) {
                Text(L.ChooseLocation.header)
                    .font(HerpiFont.semibold_16)
                    .foregroundStyle(HerpiColor.Title.primary)
                
                Text(L.ChooseLocation.description)
                    .font(HerpiFont.regular_13)
                    .foregroundStyle(HerpiColor.Title.primary)
            }
        }
    }
}
