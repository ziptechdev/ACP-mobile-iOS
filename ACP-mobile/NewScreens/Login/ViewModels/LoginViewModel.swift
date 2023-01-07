//
//  LoginViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import Foundation
import Alamofire

class LoginViewModel {

    // MARK: - Properties

    private weak var coordinator: LoginCoordinatorProtocol?
    private let service = LoginService()

    let showCloseButton: Bool

    private var termsUrl: String { "terms" }
    private var privacyPolicyUrl: String { "privacy" }

    // MARK: - Initialization

    init(coordinator: LoginCoordinatorProtocol,
         showCloseButton: Bool
    ) {
        self.coordinator = coordinator
        self.showCloseButton = showCloseButton
    }

    // MARK: - Callback

    func login(email: String, password: String) {
        let parameters: Parameters = [
            "username": email,
            "password": password
        ]

        service.login(parameters: parameters) { [weak self] data, error in
            guard let self = self else { return }

            guard let data = data, error == nil else {
                return
            }

            guard let model = try? JSONDecoder().decode(LoginResponse.self, from: data),
                  let status = model.status
            else {
                return
            }

            print(status)
            self.goToHomeScreen()
        }
    }

    // MARK: - Coordination

    func openTerms() {
        coordinator?.openLink(url: termsUrl)
    }

    func openPrivacyPolicy() {
        coordinator?.openLink(url: privacyPolicyUrl)
    }

    func dismiss() {
        coordinator?.dismiss()
    }

    private func goToHomeScreen() {
        coordinator?.goToHome()
    }
}
