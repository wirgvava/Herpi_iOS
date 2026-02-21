//
//  VenomTypeColor.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 21.02.26.
//

import SwiftUI
import HerpiUI

func venomTypeColor(hasMildVenom: Bool, venomous: Bool) -> Color {
    if hasMildVenom {
        HerpiColor.VenomType.midVenomous
    } else if venomous {
        HerpiColor.VenomType.venomous
    } else {
        HerpiColor.VenomType.noVenomous
    }
}
