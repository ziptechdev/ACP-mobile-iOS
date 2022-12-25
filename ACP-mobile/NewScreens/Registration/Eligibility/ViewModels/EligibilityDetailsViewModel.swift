//
//  EligibilityDetailsViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import Foundation

class EligibilityDetailsViewModel {

    // MARK: - Properties

    private weak var coordinator: EligibilityCoordinatorProtocol?
    var model: EligibilityModel

    private var termsUrl: String { "terms" }
    private var privacyPolicyUrl: String { "privacy" }

    private var tabNames: [String] {
        return [
            .localizedString(key: "eligibility_details_page_title"),
            .localizedString(key: "eligibility_dob_page_title"),
            .localizedString(key: "eligibility_address_page_title")
        ]
    }

    var isDateOfBirthValid: Bool {
        return checkIfAgeIsValid()
    }

    var stateOptions: [String] { model.stateOptions }

    var monthOptions: [String] { model.monthOptions }

    // MARK: - Initialization

    init(coordinator: EligibilityCoordinatorProtocol, model: EligibilityModel) {
        self.coordinator = coordinator
        self.model = model
    }

    // MARK: - Helpers

    private func checkIfAgeIsValid() -> Bool {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = dateFormatter.date(from: model.dateOfBirth),
              let age = Calendar.current.dateComponents([.year], from: date, to: now).year,
              age >= 18,
              age < 120
        else {
            return false
        }
        return true
    }

    // MARK: - Callbacks

    func numberOfTabItems() -> Int {
        return tabNames.count
    }

    func titleForTab(at index: Int) -> String {
        return tabNames[index]
    }

    // MARK: - Coordination

    func goToVerify() {
        coordinator?.goToVerify(model: model)
    }

    func openTerms() {
        coordinator?.openLink(url: termsUrl)
    }

    func openPrivacyPolicy() {
        coordinator?.openLink(url: privacyPolicyUrl)
    }

    func dismiss() {
        coordinator?.dismiss()
    }
}
