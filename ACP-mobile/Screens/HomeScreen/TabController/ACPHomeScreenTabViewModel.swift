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

    private let tabs: [ACPTabMenuImageCellModel] = [
        ACPTabMenuImageCellModel(
            title: .localizedString(key: "home_page_title"),
            imageName: "home"
        ),
        ACPTabMenuImageCellModel(
            title: .localizedString(key: "wallet_page_title"),
            imageName: "wallet"
        ),
        ACPTabMenuImageCellModel(
            title: .localizedString(key: "profile_page_title"),
            imageName: "profile"
        )
    ]

    func numberOfTabItems() -> Int {
        return tabs.count
    }

    func titleForTab(at index: Int) -> String {
        return tabs[index].title
    }

    func imageNameForTab(at index: Int) -> String {
        return tabs[index].imageName
    }
}
