//
//  MKPolygon+Extensions.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 13.02.24.
//

import MapKit

extension MKPolygon {
    convenience init(coordinates: [CLLocationCoordinate2D]) {
        self.init(coordinates: coordinates, count: coordinates.count)
    }
}
