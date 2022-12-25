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

    var onDismiss: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: ACPNavigationController

    // MARK: - Initialization

    init(navigationController: ACPNavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Start / Dismiss

    func start() {

    }
    
    // MARK: - Coordination
}
