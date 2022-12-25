//
//  AppCoordinator.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import UIKit

class AppCoordinator: Coordinator {

    // MARK: - Properties

    var window: UIWindow

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController = NavigationController()

    private var isInitialLaunch: Bool {
        return !UserDefaults.standard.bool(forKey: Constants.initialLaunch)
    }

    // MARK: - Initialization

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Coordination

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        if isInitialLaunch {
            goToWelcome()
        } else {
            goToLogin()
        }
    }

    func goToWelcome() {
        UserDefaults.standard.set(true, forKey: Constants.initialLaunch)

        let coordinator = WelcomeCoordinator(navigationController: navigationController)
        addChild(coordinator)
    }

    func goToLogin() {
        goToWelcome()
    }
}

// MARK: - Constants

extension AppCoordinator {
    private struct Constants {
        static let initialLaunch = "initialLaunch"
    }
}
