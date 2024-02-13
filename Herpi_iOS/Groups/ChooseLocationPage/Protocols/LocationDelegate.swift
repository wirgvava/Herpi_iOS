//
//  LocationDelegate.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 13.02.24.
//

import Foundation

protocol LocationDelegate: AnyObject {
    func didChangedLocationWith(lat: Double, lng: Double, name: String)
}
