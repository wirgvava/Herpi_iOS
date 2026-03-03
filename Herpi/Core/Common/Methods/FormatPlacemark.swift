//
//  FormatPlacemark.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 03.03.26.
//

import CoreLocation

func formatPlacemark(_ placemark: CLPlacemark, withStreetName: Bool = false) -> String {
    var streetName = placemark.thoroughfare ?? .empty
    let city = placemark.locality.map { $0 + " , " } ?? .empty
    let country = placemark.country ?? .empty
    
    if streetName.contains("Street") {
        streetName.removeLast(6)
        streetName.append("St. , ")
    } else if !streetName.isEmpty {
        streetName.append(" , ")
    }
    
    if streetName.isEmpty && city.isEmpty && country.isEmpty {
        return L.MainPage.Header.pickLocation
    } else if withStreetName {
        return streetName + city + country
    } else {
        return city + country
    }
}
