//
//  HerpiApp.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 09.06.25.
//

import SwiftUI
import ComposableArchitecture

@main
struct HerpiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            MainPageView(
                store: Store(initialState: MainPageView.Feature.State()) {
                    MainPageView.Feature()
                }
            )
        }
    }
}
