//
//  KYCViewController.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import UIKit

class KYCViewController: UIViewController {

    // MARK: - Properties

    private var viewModel: KYCViewModel

    // MARK: - Views

    // MARK: - Initialization

    init(viewModel: KYCViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {}

    private func setupConstraints() {}

    // MARK: - Callbacks
}

// MARK: - Constants

extension KYCViewController {

    private struct Constants {

        struct Fonts {}

        struct Strings {}
    }
}
