//
//  EligibilityRegistrationViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import Foundation
import Alamofire

class EligibilityRegistrationViewModel {

    // MARK: - Properties

    private weak var coordinator: EligibilityCoordinatorProtocol?
    private let service = EligibilityService()
    private var model: EligibilityModel

    var firstName: String { model.firstName }
    var errorCompletion: (() -> Void)?

    // MARK: - Initialization

    init(coordinator: EligibilityCoordinatorProtocol, model: EligibilityModel) {
        self.coordinator = coordinator
        self.model = model
    }

    // MARK: - Network

    func register(email: String, password: String) {
        let parameters: Parameters = [
            "username": email,
            "password": password
        ]

        service.registerUser(id: model.eligibilityCheckId, parameters: parameters) { [weak self] data, error in
            guard let self = self else { return }

            guard let data = data, error == nil else {
                self.errorCompletion?()
                return
            }

            guard let model = try? JSONDecoder().decode(EligibilityRegistrationResponse.self, from: data),
                  let userId = model.id
            else {
                self.errorCompletion?()
                return
            }

            print(userId)
            self.goToSuccess()
        }
    }

    // MARK: - Coordination

    private func goToSuccess() {
        coordinator?.goToRegistrationSuccess()
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
