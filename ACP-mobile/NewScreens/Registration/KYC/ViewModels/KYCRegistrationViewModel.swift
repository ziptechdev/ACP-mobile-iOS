//
//  KYCRegistrationViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 25/12/2022.
//

import Alamofire

class KYCRegistrationViewModel {

    // MARK: - Properties

    private weak var coordinator: KYCCoordinatorProtocol?
    private let service = KYCService()
    var model = KYCModel()

    var dismissVerifyEmail: (() -> Void)?
    var sendVerifyEmailError: ((String) -> Void)?
    var verifyEmailError: ((String) -> Void)?

    private var termsUrl: String { "terms" }
    private var privacyPolicyUrl: String { "privacy" }

    private var tabNames: [String] {
        return [
            .localizedString(key: "personal_info_page_title"),
            .localizedString(key: "identity_proof_page_title"),
            .localizedString(key: "bank_info_page_title")
        ]
    }

    // MARK: - Initialization

    init(coordinator: KYCCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Callbacks

    func numberOfTabItems() -> Int {
        return tabNames.count
    }

    func titleForTab(at index: Int) -> String {
        return tabNames[index]
    }

    // MARK: - Network

    func sendEmailCode() {
        let parameters: Parameters = ["email": model.email]

        service.verifyEmail(parameters: parameters) { [weak self] data, error in
            guard let self = self else { return }

            guard let data = data, error == nil else {
                self.sendVerifyEmailError?("Something went wrong. Try again.")
                return
            }

            guard let model = try? JSONDecoder().decode(KYCResponse.self, from: data),
                  let verificationCode = model.data?.verificationCode
            else {
                self.sendVerifyEmailError?("Something went wrong. Try again.")
                return
            }

            self.model.verificationCode = "\(verificationCode)"
            self.openVerifyEmail()
        }
    }

    func resendEmailCode() {
        sendEmailCode()
    }

    func confirmCode(_ code: String) {
        if code == model.verificationCode {
            dismissVerifyEmail?()
        } else {
            verifyEmailError?("Verification code is incorrect.")
        }
    }

    // MARK: - Coordination

    private func openVerifyEmail() {
        coordinator?.openVerifyEmail(viewModel: self)
    }

    func openTerms() {
        coordinator?.openLink(url: termsUrl)
    }

    func openPrivacyPolicy() {
        coordinator?.openLink(url: privacyPolicyUrl)
    }
}
