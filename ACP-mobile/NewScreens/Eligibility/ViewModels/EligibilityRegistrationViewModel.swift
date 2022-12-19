//
//  EligibilityRegistrationViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import Foundation

class EligibilityRegistrationViewModel {

    // MARK: - Properties

    private weak var coordinator: EligibilityCoordinatorProtocol?
    private let service = EligibilityService()
    private let model: EligibilityModel

    var isSecureEntry = true
    var firstName: String { model.firstName }

    // MARK: - Initialization

    init(coordinator: EligibilityCoordinatorProtocol, model: EligibilityModel) {
        self.coordinator = coordinator
        self.model = model
    }

    // MARK: - Network

    func register(errorCompletion: @escaping (() -> Void)) {
        service.registerUser(id: model.eligibilityCheckId) { [weak self] data, error in
            guard let self = self else { return }

//            guard let data = data, error == nil else {
//                errorCompletion()
//                return
//            }
//
//            guard let model = try? JSONDecoder().decode(EligibilityRegistrationResponse.self, from: data),
//                  let userId = model.id
//            else {
//                errorCompletion()
//                return
//            }

//            print(userId)
            self.goToSuccess()
        }
    }

    // MARK: - Coordination

    private func goToSuccess() {
        coordinator?.goToRegistrationSuccess()
    }

    func goBack() {
        coordinator?.goBack()
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
