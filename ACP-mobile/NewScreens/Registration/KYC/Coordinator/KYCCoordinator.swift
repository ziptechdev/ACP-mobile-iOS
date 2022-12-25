//
//  KYCCoordinator.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

protocol KYCCoordinatorProtocol: Coordinator {

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

    }

    // MARK: - Coordination
}
