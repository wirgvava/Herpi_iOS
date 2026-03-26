//
//  SyncProgress.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 09.03.26.
//

import Foundation

// MARK: - Language Sync Progress
/// Tracks sync progress for a single language
public struct LanguageSyncProgress: Codable, Sendable, Equatable {
    public var categoriesComplete: Bool = false
    public var reptilesComplete: Bool = false
    public var teamComplete: Bool = false
    public var faqComplete: Bool = false
    public var reptileDetailsComplete: Bool = false
    public var fetchedReptileIds: Set<Int> = []
    
    public var isComplete: Bool {
        categoriesComplete && reptilesComplete && teamComplete && faqComplete && reptileDetailsComplete
    }
    
    public var currentStep: Int {
        var step = 0
        if categoriesComplete { step += 1 }
        if reptilesComplete { step += 1 }
        if teamComplete { step += 1 }
        if faqComplete { step += 1 }
        if reptileDetailsComplete { step += 1 }
        return step
    }
    
    public static let stepsPerLanguage = 5
    
    public init(categoriesComplete: Bool = false, reptilesComplete: Bool = false, teamComplete: Bool = false, faqComplete: Bool = false, reptileDetailsComplete: Bool = false, fetchedReptileIds: Set<Int> = []) {
        self.categoriesComplete = categoriesComplete
        self.reptilesComplete = reptilesComplete
        self.teamComplete = teamComplete
        self.faqComplete = faqComplete
        self.reptileDetailsComplete = reptileDetailsComplete
        self.fetchedReptileIds = fetchedReptileIds
    }
}

// MARK: - Sync Progress
/// Tracks overall sync progress for both languages
public struct SyncProgress: Codable, Sendable, Equatable {
    public var dataStateTimestamp: Int
    
    // Progress tracking for each language (ka = Georgian, en = English)
    public var kaProgress: LanguageSyncProgress = LanguageSyncProgress()
    public var enProgress: LanguageSyncProgress = LanguageSyncProgress()
    
    // Images are language-independent, cached once for both languages
    public var imagesComplete: Bool = false
    
    public var isComplete: Bool {
        kaProgress.isComplete && enProgress.isComplete && imagesComplete
    }
    
    public var currentStep: Int {
        kaProgress.currentStep + enProgress.currentStep + (imagesComplete ? 1 : 0)
    }
    
    // Total steps: 5 per language (categories, reptiles, team, faq, reptileDetails) x 2 languages + 1 for images
    public static let totalSteps = LanguageSyncProgress.stepsPerLanguage * 2 + 1
    
    public init(dataStateTimestamp: Int, kaProgress: LanguageSyncProgress = LanguageSyncProgress(), enProgress: LanguageSyncProgress = LanguageSyncProgress(), imagesComplete: Bool = false) {
        self.dataStateTimestamp = dataStateTimestamp
        self.kaProgress = kaProgress
        self.enProgress = enProgress
        self.imagesComplete = imagesComplete
    }
    
    // MARK: - Convenience accessors for backward compatibility
    
    public var categoriesComplete: Bool {
        kaProgress.categoriesComplete && enProgress.categoriesComplete
    }
    
    public var reptilesComplete: Bool {
        kaProgress.reptilesComplete && enProgress.reptilesComplete
    }
    
    public var teamComplete: Bool {
        kaProgress.teamComplete && enProgress.teamComplete
    }
    
    public var faqComplete: Bool {
        kaProgress.faqComplete && enProgress.faqComplete
    }
    
    public var reptileDetailsComplete: Bool {
        kaProgress.reptileDetailsComplete && enProgress.reptileDetailsComplete
    }
    
    public var fetchedReptileIds: Set<Int> {
        kaProgress.fetchedReptileIds.intersection(enProgress.fetchedReptileIds)
    }
}
