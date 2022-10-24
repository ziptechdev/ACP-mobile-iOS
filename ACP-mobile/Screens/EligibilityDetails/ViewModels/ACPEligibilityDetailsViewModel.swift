//
//  ACPEligibilityDetailsViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 03/10/2022.
//

// MARK: - ACPEligibilityDetailsViewModelDelegate

class ACPEligibilityDetailsViewModel {

    // MARK: - Properties

    var model = ACPEligibilityDetailsModel()

    private let tabNames: [String] = [
        .localizedString(key: "eligibility_details_page_title"),
        .localizedString(key: "eligibility_dob_page_title"),
        .localizedString(key: "eligibility_address_page_title")
    ]

    func didTapVerify() {
        // TODO: Network call
    }

    func numberOfTabItems() -> Int {
        return tabNames.count
    }

    func titleForTab(at index: Int) -> String {
        return tabNames[index]
    }
}
