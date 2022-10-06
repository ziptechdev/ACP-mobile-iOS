//
//  ACPPersonalInfoViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit

class ACPPersonalInfoViewModel {

	// MARK: - Properties

    private let tabs = ["Personal Info", "Identity Proof", "Bank Info"]

    func numberOfTabItems() -> Int {
        return tabs.count
    }

    func titleForTab(at index: Int) -> String {
        return tabs[index]
    }
}
