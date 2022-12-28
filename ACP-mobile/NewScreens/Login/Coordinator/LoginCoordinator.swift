//
//  LoginCoordinator.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func goToLogin()
    func goToHome()
    func goToForgotPassword()
    func openLink(url: String)
}

class LoginCoordinator: LoginCoordinatorProtocol {

    // MARK: - Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: NavigationController

    let isAfterRegistration: Bool

    // MARK: - Initialization

    init(navigationController: NavigationController,
         isAfterRegistration: Bool = true
    ) {
        self.navigationController = navigationController
        self.isAfterRegistration = isAfterRegistration
    }

    // MARK: - Start

    func start() {
        goToLogin()
    }

    // MARK: - Coordination

    func goToLogin() {
        let viewModel = LoginViewModel(coordinator: self, showCloseButton: isAfterRegistration)
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToHome() {
        AppCoordinator.shared.goToHome()
    }

    func goToForgotPassword() {}

    func openLink(url: String) {
        print("Coordinator opened web url for \(url)")
        let destinationVC = UIViewController()
        destinationVC.view.backgroundColor = .white
        navigationController.present(destinationVC, animated: true)
    }
}
