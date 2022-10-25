//
//  ACPDebitCardView.swift
//  ACP-mobile
//
//  Created by Adi on 25/10/2022.
//

import UIKit

class ACPDebitCardView: UIView {

    // MARK: - Views

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "$100.50"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .gray06Dark
        return label
    }()

    private let totalBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "$100.50"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .gray06Dark
        return label
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
        backgroundColor = .coreBlue
        layer.cornerRadius = Constants.Constraints.CornerRadius
        layer.masksToBounds = true

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {}

    private func setupConstraints() {}

    // MARK: - Callbacks

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
