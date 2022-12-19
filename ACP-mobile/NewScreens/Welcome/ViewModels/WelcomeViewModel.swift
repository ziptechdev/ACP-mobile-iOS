//
//  WelcomeViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

class WelcomeViewModel {

    // MARK: - Properties

    private weak var coordinator: WelcomeCoordinatorProtocol?

    private var termsUrl: String { "terms" }
    private var privacyPolicyUrl: String { "privacy" }
    private var assistanceUrl: String { "assistance" }

    // MARK: - Initialization

    init(coordinator: WelcomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Coordination

    func goToWelcomePageOne() {
        coordinator?.goToWelcomePageOne()
    }

    func goToWelcomePageTwo() {
        coordinator?.goToWelcomePageTwo()
    }

    func goToEligibilityCheck() {
        coordinator?.goToEligibilityCheck()
    }

    func goToEligibility() {
        coordinator?.goToEligibility()
    }

    func goToKYC() {
        coordinator?.goToKYC()
    }

    func openTerms() {
        coordinator?.openLink(url: termsUrl)
    }

    func openPrivacyPolicy() {
        coordinator?.openLink(url: privacyPolicyUrl)
    }

    func openAssistanceLink() {
        coordinator?.openLink(url: assistanceUrl)
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
