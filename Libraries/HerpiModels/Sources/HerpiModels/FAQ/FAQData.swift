//
//  FAQData.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct FAQData: Sendable {
    public var opened: Bool
    public var faqElement: FAQModelElement
    
    public init(opened: Bool = false, faqElement: FAQModelElement = FAQModelElement()) {
        self.opened = opened
        self.faqElement = faqElement
    }
}
