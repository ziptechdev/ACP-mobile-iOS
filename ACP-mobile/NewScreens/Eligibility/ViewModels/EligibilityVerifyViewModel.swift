//
//  EligibilityVerifyViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import Foundation

class EligibilityVerifyViewModel {

    // MARK: - Properties

    private weak var coordinator: EligibilityCoordinatorProtocol?
    private let service: EligibilityServiceProtocol = EligibilityService()
    private var model: EligibilityModel

    var firstName: String { model.firstName }

    // MARK: - Initialization

    init(coordinator: EligibilityCoordinatorProtocol, model: EligibilityModel) {
        self.coordinator = coordinator
        self.model = model
    }

    func verifyData() {
        service.eligibilityCheck { [weak self] data, error in
            guard let self = self else { return }

            guard let data = data, error == nil else {
                self.goToFail()
                return
            }

            guard let model = try? JSONDecoder().decode(EligibilityResponse.self, from: data),
                  let id = model.eligibilityCheckId
            else {
                self.goToFail()
                return
            }

            self.model.eligibilityCheckId = id
            self.goToSuccess()
        }
    }

    // MARK: - Coordination

    func goToSuccess() {
        coordinator?.goToSuccess(model: model)
    }

    func goToFail() {
        coordinator?.goToFail()
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
