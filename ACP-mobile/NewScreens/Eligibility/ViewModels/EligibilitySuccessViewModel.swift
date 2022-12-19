//
//  EligibilitySuccessViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

class EligibilitySuccessViewModel {

    // MARK: - Properties

    private weak var coordinator: EligibilityCoordinatorProtocol?
    private let model: EligibilityModel

    var firstName: String { model.firstName }

    // MARK: - Initialization

    init(coordinator: EligibilityCoordinatorProtocol, model: EligibilityModel) {
        self.coordinator = coordinator
        self.model = model
    }

    // MARK: - Coordination

    func goToRegistration() {
        coordinator?.goToRegistration(model: model)
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
