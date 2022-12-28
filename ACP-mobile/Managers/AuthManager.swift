//
//  AuthManager.swift
//  ACP-mobile
//
//  Created by Adi on 28/12/2022.
//

import UIKit

class AuthManager {

    static let shared = AuthManager()

    // MARK: - Properties

    var accessToken: String?

    var isUserLoggedIn: Bool {
        return accessToken != nil
    }
}
