//
//  EligibilityRegistrationResponse.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

struct EligibilityRegistrationResponse: Codable {
    let id: Int?
    let username: String?
    let firstName: String?
    let lastName: String?
    let middleName: String?
    let eligibilityCheckID: String?
    let applicationID: String?
    let eligibilityCheckStatus: String?
}
