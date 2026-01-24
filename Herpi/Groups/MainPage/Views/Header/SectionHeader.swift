//
//  SectionHeader.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 22.01.26.
//

import SwiftUI
import HerpiUI

struct SectionHeader: View {
    var header: String
    var description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(header)
                    .font(HerpiFont.semibold_16)
                    .foregroundStyle(HerpiColor.Title.primary)
                
                Text(description)
                    .font(HerpiFont.regular_14)
                    .foregroundStyle(HerpiColor.Title.secondary)
            }
            
            Spacer()
        }
    }
}

#Preview {
    SectionHeader(header: "Header", description: "Description")
}
