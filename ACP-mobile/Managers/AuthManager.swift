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

    // MARK: - Views

    // MARK: - Initialization

    // MARK: - Life Cycle

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {}

    private func setupConstraints() {}

    // MARK: - Callbacks

    // MARK: - Constants

    private struct Constants {

    }
}
