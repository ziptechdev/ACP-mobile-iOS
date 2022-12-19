//
//  WelcomeCoordinator.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import UIKit

protocol WelcomeCoordinatorProtocol: Coordinator {
    func goToLandingPage()
    func goToWelcomePageOne()
    func goToWelcomePageTwo()
    func goToEligibilityCheck()
    func goToEligibility()
    func goToKYC()
    func openLink(url: String)
}

class WelcomeCoordinator: WelcomeCoordinatorProtocol {

    // MARK: - Properties

    var onDismiss: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: ACPNavigationController

    // MARK: - Initialization

    init(navigationController: ACPNavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Start / Dismiss

    func start() {
        goToLandingPage()
    }

    func dismiss() {
        navigationController.popToRootViewController(animated: true)
    }

    // MARK: - Coordination

    func goToLandingPage() {
        let viewModel = WelcomeViewModel(coordinator: self)
        let destinationVC = LandingViewController(viewModel: viewModel)
        navigationController.setViewControllers([destinationVC], animated: true)
    }

    func goToWelcomePageOne() {
        let viewModel = WelcomeViewModel(coordinator: self)
        let destinationVC = WelcomeViewController(viewModel: viewModel)
        navigationController.pushViewController(destinationVC, animated: true)
    }

    func goToWelcomePageTwo() {
        let viewModel = WelcomeViewModel(coordinator: self)
        let destinationVC = TermsViewController(viewModel: viewModel)
        navigationController.pushViewController(destinationVC, animated: true)
    }

    func goToEligibilityCheck() {
        let viewModel = WelcomeViewModel(coordinator: self)
        let destinationVC = EligibilityCheckViewController(viewModel: viewModel)
        navigationController.pushViewController(destinationVC, animated: true)
    }

    func openLink(url: String) {
        print("Coordinator opened web url for \(url)")
        let destinationVC = UIViewController()
        destinationVC.view.backgroundColor = .white
        navigationController.present(destinationVC, animated: true)
    }

    func goToEligibility() {
        let coordinator = EligibilityCoordinator(navigationController: navigationController)
        addChild(coordinator)
        coordinator.onDismiss = { [weak self] in
            self?.removeChild(coordinator)
        }
        coordinator.goToKYCCoordinator = { [weak self] in
            self?.removeChild(coordinator)
            self?.goToKYC()
        }
    }

    func goToKYC() {
        let coordinator = KYCCoordinator(navigationController: navigationController)
        addChild(coordinator)
        coordinator.onDismiss = { [weak self] in
            self?.removeChild(coordinator)
        }
    }
}
