//
//  Family.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct Family: Codable, Sendable, Identifiable, Equatable {
    public var id: Int
    public var name: String
    public var image: String?
    
    public init(
        id: Int = .zero,
        name: String = .empty,
        image: String? = nil
    ) {
        self.id = id
        self.name = name
        self.image = image
    }
}

// MARK: - Mock
public let mockFamily: Family = .init(
    id: 0,
    name: "Colubridae",
    image: "https://www.bto.org/sites/default/files/styles/400_wide/public/shared_images/gbw/species/grass-snake/grass-snake-herpsgrasnphilipparkerassociates300x200.jpg?itok=v-GV3iYq"
)
