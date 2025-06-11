//
//  Optional+Extensions.swift
//  HerpiFoundation
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//


public extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? .empty
    }
}

public extension Optional where Wrapped == Int {
    var orZero: Int {
        self ?? .zero
    }
}

public extension Optional where Wrapped == Double {
    var orZero: Double {
        self ?? .zero
    }
}
