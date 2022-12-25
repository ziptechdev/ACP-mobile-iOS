//
//  EligibilityRegistrationSuccessViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import UIKit

class EligibilityRegistrationSuccessViewModel {

    // MARK: - Properties

    private weak var coordinator: EligibilityCoordinatorProtocol?

    private var nationalVerifierUrl: String { "nationalVerifier" }

    // MARK: - Initialization

    init(coordinator: EligibilityCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Coordination

    func goToLogin() {
        coordinator?.goToLogin()
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
