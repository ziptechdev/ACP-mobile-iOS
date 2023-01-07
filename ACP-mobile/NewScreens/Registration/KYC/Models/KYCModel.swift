//
//  KYCModel.swift
//  ACP-mobile
//
//  Created by Adi on 25/12/2022.
//

import Foundation

struct KYCModel {
    var firstName = ""
    var lastName = ""
    var email = ""
    var phoneNumber = ""
    var password = ""
    var ssn = ""
    var bankName = ""
    var bankNumber = ""
    var accountHolderName = ""
    var accountNumber = ""
    var expirationDate = ""
    var verificationCode = ""
}

struct KYCDocumentsModel {
    var documentIdFront: Data?
    var documentIdBack: Data?
    var selfie: Data?
    var username = ""
    var userIp = ""
    var userState = ""
    var consentOptained = ""
    var consentOptainedAt = ""

}
