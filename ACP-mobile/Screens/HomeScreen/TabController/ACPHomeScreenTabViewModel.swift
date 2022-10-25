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

    private let tabs: [(titleString: String, imageName: String)] = [
        (.localizedString(key: "home_page_title"), "home"),
        (.localizedString(key: "wallet_page_title"), "wallet"),
        (.localizedString(key: "profile_page_title"), "profile")
    ]

    func numberOfTabItems() -> Int {
        return tabs.count
    }

    func titleForTab(at index: Int) -> String {
        return tabs[index].titleString
    }

    func imageNameForTab(at index: Int) -> String {
        return tabs[index].imageName
    }
}
