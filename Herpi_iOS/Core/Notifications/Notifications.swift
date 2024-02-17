//
//  Notifications.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 09.02.24.
//

import Foundation

enum Notifications: String {
    
    case didLoadedData = "DidLoadedData"
    case languageSwitched = "LanguageSwitched"
    case updateHeightConstraints = "UpdateHeightConstraints"
    
    var notificationName: Notification.Name {
        return Notification.Name(self.rawValue)
    }
}
