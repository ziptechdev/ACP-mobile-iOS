//
//  EligibilityFailViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

class EligibilityFailViewModel {

    // MARK: - Properties

    private weak var coordinator: EligibilityCoordinatorProtocol?

    private var nationalVerifierUrl: String { "nationalVerifier" }

    // MARK: - Initialization

    init(coordinator: EligibilityCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Coordination

    func tryAgain() {
        coordinator?.tryAgain()
    }

    func goToKYC() {
        coordinator?.goToKYC()
    }

    func openNationalVerifier() {
        coordinator?.openLink(url: nationalVerifierUrl)
    }
}
