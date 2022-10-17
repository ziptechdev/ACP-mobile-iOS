//
//  ACPEligibilityDetailsDOBModel.swift
//  ACP-mobile
//
//  Created by Adi on 03/10/2022.
//

import UIKit

struct ACPEligibilityDetailsDOBModel {

	// MARK: - Properties

    var month = 0
    var day = ""
    var year = ""
    var ssn = ""

    var monthOptions: [String] = {
        let range = 1...12
        return range.map { "\($0) / \(String.localizedString(key: "month_\($0)"))" }
    }()
}
