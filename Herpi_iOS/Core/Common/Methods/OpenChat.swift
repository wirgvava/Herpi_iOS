//
//  OpenChat.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import UIKit

func openChat(){
    if let url = URL(string: Constants.chatUrl) {
        AppAnalytics.logEvents(with: .click_chat, paramName: nil, paramData: nil)
        UIApplication.shared.open(url, options: [:])
    }
}
