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
            return "Name"
        case .second:
            return "Date of Birth"
        case .third:
            return "Address"
        }
    }

    func didTapVerify() {
        // TODO: Network call

    }
}
