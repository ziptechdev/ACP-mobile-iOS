//
//  ACPHomeScreenTabViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 25/10/2022.
//

import UIKit

class ACPHomeScreenTabViewModel {

    // MARK: - Properties

    var currentTab = 0

    private let tabs = [
        "home",
        "wallet",
        "profile"
    ]

    var isWalletEmpty: Bool = false

    func numberOfTabItems() -> Int {
        return tabs.count
    }

    func titleForTab(at index: Int) -> String {
        let titleKey = "\(tabs[index])_tab_title"
        return .localizedString(key: titleKey)
    }

    func titleForPage(at index: Int) -> String {
        let titleKey = "\(tabs[index])_page_title"
        return .localizedString(key: titleKey)
    }

    func imageNameForTab(at index: Int) -> String {
        return tabs[index]
    }
}
