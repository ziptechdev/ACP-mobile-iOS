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
        return getDateOfBirth() != nil
    }

    var stateOptions: [String] {
        return [
            "AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "GU", "HI", "IA",
            "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC",
            "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD",
            "TN", "TX", "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY"
        ]
    }

    var monthOptions: [String] {
        let range = 1...12
        return range.map { "\($0) / \(String.localizedString(key: "month_\($0)"))" }
    }

    // MARK: - Initialization

    init(coordinator: EligibilityCoordinatorProtocol, model: EligibilityModel) {
        self.coordinator = coordinator
        self.model = model
    }

    // MARK: - Helpers

    private func getDateOfBirth() -> String? {
        let monthString = "\(model.day)-\(model.month + 1)-\(model.year)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        guard let date = dateFormatter.date(from: monthString),
              checkIfAgeIsValid(date: date)
        else {
            return nil
        }

        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    private func checkIfAgeIsValid(date: Date) -> Bool {
        let now = Date()
        let calendar = Calendar.current

        guard let age = calendar.dateComponents([.year], from: date, to: now).year,
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
