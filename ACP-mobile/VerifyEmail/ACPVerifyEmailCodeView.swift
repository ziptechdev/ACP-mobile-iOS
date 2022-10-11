//
//  ACPVerifyEmailCodeView.swift
//  ACP-mobile
//
//  Created by Adi on 11/10/2022.
//

import UIKit

class ACPVerifyEmailCodeView: UIView {

	// MARK: - Properties

    // MARK: - Views

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
        
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
