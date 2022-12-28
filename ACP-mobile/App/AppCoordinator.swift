//
//  AppCoordinator.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import UIKit

class AppCoordinator: Coordinator {

    static var shared = AppCoordinator()

    // MARK: - Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController = NavigationController()

    private var isInitialLaunch: Bool {
        return !UserDefaults.standard.bool(forKey: Constants.initialLaunch)
    }

    // MARK: - Start / Dismiss

    func start() {
        goToWelcome()

//        if isInitialLaunch {
//            goToWelcome()
//        } else if AuthManager.shared.isUserLoggedIn {
//            goToHome()
//        } else {
//            goToLogin()
//        }
    }

    // MARK: - Coordination

    func goToWelcome() {
        UserDefaults.standard.set(true, forKey: Constants.initialLaunch)

        let coordinator = KYCCoordinator(navigationController: navigationController)
        addChild(coordinator)
    }

    func goToLogin() {
        let coordinator = LoginCoordinator(
            navigationController: navigationController,
            isAfterRegistration: false
        )
        addChild(coordinator)
    }

    func goToHome() {
        navigationController.setViewControllers([ACPHomeScreenTabViewController()], animated: true)
    }
}

// MARK: - Constants

extension AppCoordinator {
    private struct Constants {
        static let initialLaunch = "initialLaunch"
    }
}
