//
//  SyncProgress.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 09.03.26.
//

import Foundation

public struct SyncProgress: Codable, Sendable, Equatable {
    public var dataStateTimestamp: Int
    public var categoriesComplete: Bool = false
    public var reptilesComplete: Bool = false
    public var teamComplete: Bool = false
    public var faqComplete: Bool = false
    public var reptileDetailsComplete: Bool = false
    public var imagesComplete: Bool = false
    public var fetchedReptileIds: Set<Int> = []
    
    public var isComplete: Bool {
        categoriesComplete && reptilesComplete && teamComplete && faqComplete && reptileDetailsComplete && imagesComplete
    }
    
    public var currentStep: Int {
        var step = 0
        if categoriesComplete { step += 1 }
        if reptilesComplete { step += 1 }
        if teamComplete { step += 1 }
        if faqComplete { step += 1 }
        if reptileDetailsComplete { step += 1 }
        if imagesComplete { step += 1 }
        return step
    }
    
    public static let totalSteps = 6
    
    public init(dataStateTimestamp: Int, categoriesComplete: Bool = false, reptilesComplete: Bool = false, teamComplete: Bool = false, faqComplete: Bool = false, reptileDetailsComplete: Bool = false, imagesComplete: Bool = false, fetchedReptileIds: Set<Int> = []) {
        self.dataStateTimestamp = dataStateTimestamp
        self.categoriesComplete = categoriesComplete
        self.reptilesComplete = reptilesComplete
        self.teamComplete = teamComplete
        self.faqComplete = faqComplete
        self.reptileDetailsComplete = reptileDetailsComplete
        self.imagesComplete = imagesComplete
        self.fetchedReptileIds = fetchedReptileIds
    }
}
