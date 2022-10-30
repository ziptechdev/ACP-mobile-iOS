//
//  ACPTransactionsCell.swift
//  ACP-mobile
//
//  Created by Adi on 29/10/2022.
//

import UIKit
import SnapKit

class ACPTransactionsCell: UITableViewCell {

    // MARK: - Properties

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray06Dark
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray01Light
        return label
    }()

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .successGreen
        return label
    }()

    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "wallet_transactions_details")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .coreBlue
        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    // MARK: - UI

    private func setupUI() {
        backgroundColor = .clear
        layer.cornerRadius = Constants.CornerRadius

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(detailsLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.VerticalInset)
            make.left.equalToSuperview().inset(Constants.HorizontalInset)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.VerticalInset)
            make.bottom.equalToSuperview().inset(Constants.VerticalInset)
            make.left.equalToSuperview().inset(Constants.HorizontalInset)
        }

        balanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.VerticalInset)
            make.right.equalToSuperview().inset(Constants.HorizontalInset)
        }

        detailsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.VerticalInset)
            make.right.equalToSuperview().inset(Constants.HorizontalInset)
        }
    }

    func configureCell() {
        titleLabel.text = "Funds Received"
        dateLabel.text = "21/09/2022"
        balanceLabel.text = "+$10.00"
    }

    // MARK: - Constants

    private struct Constants {
        static let CornerRadius: CGFloat = 10

        static let VerticalInset: CGFloat = 10
        static let HorizontalInset: CGFloat = 20
    }
}
