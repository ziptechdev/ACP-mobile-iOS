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

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: NavigationController

    // MARK: - Initialization

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Start / Dismiss

    func start() {
        goToLandingPage()
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
        coordinator.goToKYCCoordinator = { [weak self] in
            self?.goToKYC()
            self?.navigationController.popInTheBackgroundToVC(EligibilityCheckViewController.self)
        }
    }

    func goToKYC() {
        let coordinator = KYCCoordinator(navigationController: navigationController)
        addChild(coordinator)
    }
}
