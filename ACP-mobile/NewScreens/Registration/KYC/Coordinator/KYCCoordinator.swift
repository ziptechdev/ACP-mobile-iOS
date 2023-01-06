//
//  KYCCoordinator.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import UIKit

protocol KYCCoordinatorProtocol: Coordinator {
    func goToStart()
    func goToPersonalDetails()
    func openVerifyEmail(viewModel: KYCRegistrationViewModel)
    func goToRegistrationComplete()
    func goToLogin()
    func openLink(url: String)
}

class KYCCoordinator: KYCCoordinatorProtocol {

    // MARK: - Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: NavigationController

    // MARK: - Initialization

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Start / Dismiss

    func start() {
        goToStart()
    }

    // MARK: - Coordination

    func goToStart() {
        let viewModel = KYCRegistrationStartViewModel(coordinator: self)
        let viewController = KYCRegistrationStartViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToPersonalDetails() {
        let viewModel = KYCRegistrationViewModel(coordinator: self)
        let viewModelDocuments = KYCDocumentsViewModel(coordinator: self)
        let viewController = KYCRegistrationBaseViewController(viewModel: viewModel, viewModelDocuments: viewModelDocuments)
        navigationController.pushViewController(viewController, animated: true)
    }

    func openVerifyEmail(viewModel: KYCRegistrationViewModel) {
        let viewController = KYCVerifyEmailViewController(viewModel: viewModel)
        navigationController.present(viewController, animated: true)
    }

    func goToRegistrationComplete() {
        let viewModel = KYCRegistrationCompleteViewModel(coordinator: self)
        let viewController = KYCRegistrationCompleteViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToLogin() {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        addChild(coordinator)
    }

    func openLink(url: String) {
        print("Coordinator opened web url for \(url)")
        let destinationVC = UIViewController()
        destinationVC.view.backgroundColor = .white
        navigationController.present(destinationVC, animated: true)
    }
}
