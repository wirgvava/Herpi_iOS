//
//  JSONDecoder.swift
//  HerpiFoundation
//
//  Created by Konstantine Tsirgvava on 09.03.26.
//

import Foundation

public extension JSONDecoder {
    static var apiDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
