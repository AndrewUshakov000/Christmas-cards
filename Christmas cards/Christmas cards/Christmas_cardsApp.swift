//
//  Christmas_cardsApp.swift
//  Christmas cards
//
//  Created by Andrew Ushakov on 12/16/21.
//

import SwiftUI
import GoogleMobileAds

@main
struct Christmas_cardsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()

        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}
