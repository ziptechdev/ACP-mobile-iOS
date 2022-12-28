//
//  EligibilityZipCodeViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import UIKit

class EligibilityZipCodeViewModel {

    // MARK: - Properties

    private weak var coordinator: EligibilityCoordinatorProtocol?
    var model = EligibilityModel()

    private var termsUrl: String { "terms" }
    private var privacyPolicyUrl: String { "privacy" }

    // MARK: - Initialization

    init(coordinator: EligibilityCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Coordination

    func goToDetails() {
        coordinator?.goToDetails(model: model)
    }

    func openTerms() {
        coordinator?.openLink(url: termsUrl)
    }

    func openPrivacyPolicy() {
        coordinator?.openLink(url: privacyPolicyUrl)
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
