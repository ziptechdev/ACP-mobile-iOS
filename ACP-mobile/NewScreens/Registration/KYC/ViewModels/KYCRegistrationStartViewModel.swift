//
//  KYCRegistrationStartViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 25/12/2022.
//

class KYCRegistrationStartViewModel {

    // MARK: - Properties

    private weak var coordinator: KYCCoordinatorProtocol?

    private var termsUrl: String { "terms" }
    private var privacyPolicyUrl: String { "privacy" }
    private var partnersUrl: String { "partners" }

    // MARK: - Initialization

    init(coordinator: KYCCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Callback

    func dismiss() {
        coordinator?.dismiss()
    }

    func goToPersonalDetails() {
        coordinator?.goToPersonalDetails()
    }

    func openPartners() {
        coordinator?.openLink(url: partnersUrl)
    }

    func openTerms() {
        coordinator?.openLink(url: termsUrl)
    }

    func openPrivacyPolicy() {
        coordinator?.openLink(url: privacyPolicyUrl)
    }
}
