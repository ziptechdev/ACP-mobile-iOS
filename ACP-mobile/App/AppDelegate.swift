//
//  AppDelegate.swift
//  ACP-mobile
//
//  Created by Adi on 26/09/2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = AppCoordinator.shared.navigationController
        window.makeKeyAndVisible()

        AppCoordinator.shared.start()
        FirebaseApp.configure()

        self.window = window

        return true
    }
}
