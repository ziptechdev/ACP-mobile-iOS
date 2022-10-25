//
//  ACPWalletViewController.swift
//  ACP-mobile
//
//  Created by Adi on 25/10/2022.
//

import UIKit
import SnapKit

class ACPWalletViewController: UIViewController {

	// MARK: - Properties

    // MARK: - Views

    let debitCard = ACPDebitCardView()

    private lazy var newCardButton: ACPImageButton = {
        let button = ACPImageButton(
            spacing: Constants.Constraints.ButtonContentSpacing,
            cornerRadius: Constants.Constraints.ButtonCornerRadius,
            imageName: "plus",
            isLeft: true
        )
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.localizedString(key: "wallet_btn"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private let transactionsLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "wallet_transactions")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

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

    private func addSubviews() {
        view.addSubview(debitCard)
        view.addSubview(newCardButton)
        view.addSubview(transactionsLabel)
    }

    private func setupConstraints() {
        debitCard.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.CardHeight)
            make.top.equalToSuperview().inset(Constants.Constraints.CardOffset)
        }

        newCardButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(debitCard.snp.bottom).offset(Constants.Constraints.ButtonOffset)
        }

        transactionsLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(newCardButton.snp.bottom).offset(Constants.Constraints.TitleOffset)
        }
    }

    // MARK: - Callbacks

    @objc func didTapButton() {
        // TODO: Add action
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ContentInset: CGFloat = 35

            static let CardOffset: CGFloat = 40
            static let CardHeight: CGFloat = 180

            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10
            static let ButtonHeight: CGFloat = 46
            static let ButtonOffset: CGFloat = 30

            static let TitleOffset: CGFloat = 60
        }
    }
}
