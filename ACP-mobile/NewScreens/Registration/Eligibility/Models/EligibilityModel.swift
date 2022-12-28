//
//  EligibilityModel.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

struct EligibilityModel {
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var selectedMonth = 0
    var day = ""
    var year = ""
    var ssn = ""
    var address = ""
    var city = ""
    var selectedState = 0
    var zipCode = ""
    var eligibilityCheckId = ""

    var state: String { stateOptions[selectedState] }

    var month: Int { selectedMonth + 1 }

    var dateOfBirth: String {
        return "\(year)-\(month)-\(day)"
    }

    var zipCodeString: String {
        return zipCode.replacingOccurrences(of: " - ", with: "")
    }

    var stateOptions: [String] {
        return [
            "AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "GU", "HI", "IA",
            "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC",
            "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD",
            "TN", "TX", "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY"
        ]
    }

    var monthOptions: [String] {
        let range = 1...12
        return range.map { "\($0) / \(String.localizedString(key: "month_\($0)"))" }
    }
}
