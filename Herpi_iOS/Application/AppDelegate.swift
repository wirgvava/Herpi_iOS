//
//  AppDelegate.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 03.02.24.
//

import UIKit
import Firebase
import FirebaseCore
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let shared = AppDelegate()
    private let serverManager = ApiManager()
    private let group = DispatchGroup()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        getData()
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}

// MARK: - handle Responses
extension AppDelegate {
    func getData(){
        self.getCategories()
        self.getReptiles()
        group.notify(queue: .main) {
            let center = NotificationCenter.default
            center.post(name: Notifications.didLoadedData.notificationName, object: nil)
        }
    }
    
    func getCategories(){
        group.enter()
        serverManager.getCategories { model, error in
            if let error = error {
                fatalError(error.localizedDescription)
            } else if let model = model {
                DataManager.shared.categories = model
            }
        }
    }
    
    func getReptiles(){
        serverManager.getReptilesList { model, error in
            if let error = error {
                fatalError(error.localizedDescription)
            } else if let model = model {
                DataManager.shared.reptiles = model
                self.group.leave()
            }
        }
    }
}
