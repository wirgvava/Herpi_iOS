//
//  VenomTypeString.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 21.02.26.
//


func venomTypeString(hasMildVenom: Bool, venomous: Bool) -> String {
    if hasMildVenom {
        L.VenomType.midVenomous
    } else if venomous {
        L.VenomType.venomous
    } else {
        L.VenomType.noVenomous
    }
}