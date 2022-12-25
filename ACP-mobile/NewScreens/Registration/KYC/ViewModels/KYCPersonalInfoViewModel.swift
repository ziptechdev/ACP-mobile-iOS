//
//  KYCPersonalInfoViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 25/12/2022.
//

class KYCPersonalInfoViewModel {

    // MARK: - Properties

    private weak var coordinator: KYCCoordinatorProtocol?
    private let service = KYCService()
    var model = KYCModel()

    var nextTab: (() -> Void)?

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

    func sendEmailCode() {}

    func resendEmailCode() {}

    func confirmCode(_ code: String) {}

    // MARK: - Coordination

    func openVerifyEmail() {
        coordinator?.openVerifyEmail(viewModel: self)
    }

    func openTerms() {
        coordinator?.openLink(url: termsUrl)
    }

    func openPrivacyPolicy() {
        coordinator?.openLink(url: privacyPolicyUrl)
    }
}
