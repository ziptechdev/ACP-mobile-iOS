//
//  EligibilityFailViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

class EligibilityFailViewModel {

    // MARK: - Properties

    private weak var coordinator: EligibilityCoordinatorProtocol?

    // MARK: - Initialization

    init(coordinator: EligibilityCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Coordination

    func tryAgain() {
        coordinator?.tryAgain()
    }

    func goToRegistration() {
        coordinator?.goToRegistration()
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
