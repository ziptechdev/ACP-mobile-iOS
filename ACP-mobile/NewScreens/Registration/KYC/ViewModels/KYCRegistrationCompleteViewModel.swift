//
//  KYCRegistrationCompleteViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 28/12/2022.
//

class KYCRegistrationCompleteViewModel {

    // MARK: - Properties

    private weak var coordinator: KYCCoordinatorProtocol?

    // MARK: - Initialization

    init(coordinator: KYCCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Callback

    func dismiss() {
        coordinator?.dismiss()
    }

    func goToLogin() {
        coordinator?.goToLogin()
    }
}
