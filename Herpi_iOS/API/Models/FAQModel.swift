//
//  FAQModel.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import Foundation

struct FAQModelElement: Codable {
    let id: Int?
    let question, answer: String?
}

typealias FAQModel = [FAQModelElement]

struct FAQData {
    var opened: Bool
    var faqElement: FAQModelElement
}
