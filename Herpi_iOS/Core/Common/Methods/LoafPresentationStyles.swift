//
//  LoafPresentationStyles.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 06.02.24.
//

import UIKit
import Loaf

func showError(message: Error, sender: UIViewController) {
    Loaf(message.localizedDescription, state: .error, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender).show()
}

func showInfo(message: String, sender: UIViewController){
    Loaf(message, state: .info, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender).show()
}
