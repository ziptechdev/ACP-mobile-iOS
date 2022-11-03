//
//  ACPEmptyWalletViewController.swift
//  ACP-mobile
//
//  Created by Adi on 25/10/2022.
//

import UIKit
import SnapKit

class ACPEmptyWalletViewController: UIViewController {

    // MARK: - Views

    let balanceView = ACPEmptyWalletBalanceView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "empty_wallet_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(key: "empty_wallet_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        return label
    }()

    private lazy var newCardButton: ACPShadowButton = {
        let button = ACPShadowButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "empty_wallet_btn")
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

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

    private func addSubviews() {
        view.addSubview(balanceView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(newCardButton)
    }

    private func setupConstraints() {
        balanceView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceView.snp.bottom).offset(Constants.Constraints.TitleOffsetVertical)
            make.right.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffsetVertical)
            make.right.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
        }

        newCardButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
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

            static let TitleOffsetVertical: CGFloat = 30

            static let SubtitleOffsetVertical: CGFloat = 10

            static let ButtonCornerRadius: CGFloat = 10
            static let ButtonHeight: CGFloat = 46
            static let ButtonOffsetVertical: CGFloat = 30
        }
    }
}
