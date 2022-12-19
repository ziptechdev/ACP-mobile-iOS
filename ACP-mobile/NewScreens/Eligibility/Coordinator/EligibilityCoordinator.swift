//
//  EligibilityCoordinator.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import UIKit

protocol EligibilityCoordinatorProtocol: Coordinator {
    func goBack()
    func goToZipCode()
    func goToDetails(model: EligibilityModel)
    func goToVerify(model: EligibilityModel)
    func goToSuccess(model: EligibilityModel)
    func goToFail()
    func tryAgain()
    func goToRegistration(model: EligibilityModel)
    func goToRegistrationSuccess()
    func goToLogin()
    func goToKYC()
    func openLink(url: String)
}

class EligibilityCoordinator: EligibilityCoordinatorProtocol {

    // MARK: - Properties

    var onDismiss: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: ACPNavigationController

    var goToKYCCoordinator: (() -> Void)?

    // MARK: - Initialization

    init(navigationController: ACPNavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Start / Dismiss

    func start() {
        goToZipCode()
    }

    func dismiss() {
        onDismiss?()
        navigationController.popToRootViewController(animated: true)
    }

    func goBack() {
        onDismiss?()
        navigationController.popViewController(animated: true)
    }

    // MARK: - Coordination

    func goToZipCode() {
        let viewModel = EligibilityZipCodeViewModel(coordinator: self)
        let destinationVC = EligibilityZipCodeViewController(viewModel: viewModel)
        navigationController.pushViewController(destinationVC, animated: true)
    }

    func goToDetails(model: EligibilityModel) {
        let viewModel = EligibilityDetailsViewModel(coordinator: self, model: model)
        let destinationVC = EligibilityDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(destinationVC, animated: true)
    }

    func goToVerify(model: EligibilityModel) {
        let viewModel = EligibilityVerifyViewModel(coordinator: self, model: model)
        let destinationVC = EligibilityVerifyViewController(viewModel: viewModel)
        navigationController.pushViewController(destinationVC, animated: true)
    }

    func goToSuccess(model: EligibilityModel) {
        let viewModel = EligibilitySuccessViewModel(coordinator: self, model: model)
        let viewController = EligibilitySuccessViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToFail() {
        let viewModel = EligibilityFailViewModel(coordinator: self)
        let viewController = EligibilityFailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func tryAgain() {
        goToZipCode()
        navigationController.popInTheBackgroundToVC(EligibilityCheckViewController.self)
    }

    func goToRegistration(model: EligibilityModel) {
        let viewModel = EligibilityRegistrationViewModel(coordinator: self, model: model)
        let viewController = EligibilityRegistrationViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        navigationController.popInTheBackgroundToVC(EligibilityCheckViewController.self)
    }

    func goToRegistrationSuccess() {
        let viewModel = EligibilityRegistrationSuccessViewModel(coordinator: self)
        let viewController = EligibilityRegistrationSuccessViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToKYC() {
        goToKYCCoordinator?()
    }

    func goToLogin() {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        addChild(coordinator)
        coordinator.onDismiss = { [weak self] in
            self?.removeChild(coordinator)
            self?.dismiss()
        }
    }

    func openLink(url: String) {
        print("Coordinator opened web url for \(url)")
        let destinationVC = UIViewController()
        destinationVC.view.backgroundColor = .white
        navigationController.present(destinationVC, animated: true)
    }
}
