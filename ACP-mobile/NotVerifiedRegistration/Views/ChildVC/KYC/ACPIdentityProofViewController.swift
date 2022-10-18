//
//  ACPIdentityProofViewController.swift
//  ACP-mobile
//
//  Created by Adi on 19/10/2022.
//

import UIKit

class ACPIdentityProofViewController: UIViewController {

	// MARK: - Properties
    
    weak var delegate: ACPTabMenuDelegate?

    // MARK: - Views

    // MARK: - Initialization

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

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
