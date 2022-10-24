//
//  ACPPersonalInfoViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit

class ACPPersonalInfoViewModel {

	// MARK: - Properties

    private let tabNames: [String] = [
        .localizedString(key: "personal_info_page_title"),
        .localizedString(key: "identity_proof_page_title"),
        .localizedString(key: "bank_info_page_title")
    ]

    func numberOfTabItems() -> Int {
        return tabNames.count
    }

    func titleForTab(at index: Int) -> String {
        return tabNames[index]
    }
}
