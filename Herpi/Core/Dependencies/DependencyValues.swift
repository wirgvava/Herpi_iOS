//
//  DependencyValues.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 03.03.26.
//

import ComposableArchitecture

extension DependencyValues {
    var locationClient: LocationClient {
        get { self[LocationClient.self] }
        set { self[LocationClient.self] = newValue }
    }
}
