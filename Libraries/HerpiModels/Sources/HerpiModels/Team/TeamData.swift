//
//  TeamData.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct TeamData: Sendable {
    public var opened: Bool
    public var teamMember: TeamMember
    
    public init(opened: Bool = false, teamMember: TeamMember = TeamMember()) {
        self.opened = opened
        self.teamMember = teamMember
    }
}
