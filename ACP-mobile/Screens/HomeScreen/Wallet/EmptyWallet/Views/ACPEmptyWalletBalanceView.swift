//
//  ACPEmptyWalletBalanceView.swift
//  ACP-mobile
//
//  Created by Adi on 25/10/2022.
//

import UIKit
import SnapKit

class ACPEmptyWalletBalanceView: UIView {

    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedTitleText()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "$100.50"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .gray06Dark
        return label
    }()

    private let rightArrowView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "right_chevron")
        view.image = image
        return view
    }()

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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .coreBrown.withAlphaComponent(0.14)
        layer.cornerRadius = Constants.Constraints.CornerRadius
        layer.masksToBounds = true

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(balanceLabel)
        addSubview(rightArrowView)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(Constants.Constraints.TitleInset)
        }

        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.BalanceOffset)
            make.left.bottom.equalToSuperview().inset(Constants.Constraints.TitleInset)
        }

        rightArrowView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.Constraints.ImageInset)
            make.centerY.equalToSuperview()
            make.height.equalTo(Constants.Constraints.ImageSize)
        }
    }

    private func attributedTitleText() -> NSMutableAttributedString {
        let string: NSMutableAttributedString = .localizedString(key: "empty_wallet_balance")
        let highlightRange = string.range(of: .localizedString(key: "empty_wallet_balance_highlight"))

        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .medium))
        string.addAttribute(.foregroundColor, value: UIColor.gray06Dark)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: highlightRange)

        return string
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let CornerRadius: CGFloat = 10

            static let TitleInset: CGFloat = 20
            static let BalanceOffset: CGFloat = 10

            static let ImageSize: CGFloat = 12
            static let ImageInset: CGFloat = 20
        }
    }
}
