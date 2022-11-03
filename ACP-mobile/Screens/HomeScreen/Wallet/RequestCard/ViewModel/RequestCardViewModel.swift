//
//  RequestCardViewModel.swift
//  ACP-mobile
//
//  Created by Abi  on 31. 10. 2022..
//

import UIKit

struct RequestCardViewModel {

    // MARK: - Properties

    var firstName = "John"
    var lastName = "Doe"
    var address = "1902 Pennsylvania Ave"
    var city = "Austin"
    var state = 46
    var zipCode = "92805 - 1483"
    var phoneNumber = "+1 34 9123 137"

    var stateOptions = [
        "AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "GU", "HI", "IA",
        "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC",
        "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD",
        "TN", "TX", "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY"
    ]
}
