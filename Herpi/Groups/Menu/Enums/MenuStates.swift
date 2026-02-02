//
//  MenuStates.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 31.01.26.
//


enum MenuStates: String, CaseIterable {
    case main
    case team
    case faq
    
    var title: String {
        switch self {
        case .main: return L.Menu.main
        case .team: return L.Menu.team
        case .faq: return L.Menu.faq
        }
    }
}
