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
    private var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = AppCoordinator(window: window)

        appCoordinator.start()
        FirebaseApp.configure()

        self.window = window
        self.appCoordinator = appCoordinator

        return true
    }
}
