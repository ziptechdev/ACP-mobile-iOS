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
    func goToEligibilityRegistration(with id: String)
    func goToRegistration()
}

class EligibilityCoordinator: EligibilityCoordinatorProtocol {

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
        goToDetails(model: EligibilityModel())
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

    func goToEligibilityRegistration(with id: String) {
        print(id)
        let viewController = ACPVerifiedRegistrationViewController()
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToRegistration() {
        let viewController = ACPNotVerifiedRegistrationViewController()
        navigationController.pushViewController(viewController, animated: true)
        navigationController.popInTheBackgroundToVC(EligibilityCheckViewController.self)
    }
}
