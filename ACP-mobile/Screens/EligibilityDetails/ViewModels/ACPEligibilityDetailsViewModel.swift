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

    func titleForTab(at index: ACPTopTabMenuViewController.TabIndex) -> String {
        switch index {
        case .first:
            return .localizedString(key: "eligibility_details_page_title")
        case .second:
            return .localizedString(key: "eligibility_dob_page_title")
        case .third:
            return .localizedString(key: "eligibility_address_page_title")
        }
    }

    func didTapVerify() {
        // TODO: Network call

    }
}
