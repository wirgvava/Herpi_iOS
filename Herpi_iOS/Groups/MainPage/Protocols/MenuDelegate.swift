//
//  MenuDelegate.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//

import Foundation

protocol MenuDelegate: AnyObject {
    func didTapContactButton()
    func didTapTeamButton()
    func didTapFaqButton()
    func didTapSettingsButton()
    func didSwitchedLanguage()
}
