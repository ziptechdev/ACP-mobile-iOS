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

    private let tabs = ["Name", "Date of Birth", "Address"]

    func didTapVerify() {
        // TODO: Network call
    }

    func numberOfTabItems() -> Int {
        return tabs.count
    }

    func titleForTab(at index: Int) -> String {
        return tabs[index]
    }
}
