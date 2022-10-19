//
//  ACPHomeScreenEligibilityHeaderView.swift
//  ACP-mobile
//
//  Created by Adi on 29/09/2022.
//

import UIKit
import SnapKit

class ACPHomeScreenEligibilityHeaderView: UITableViewHeaderFooterView {

    // MARK: - Views

    private let containerView = UIView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.numberOfLines = 0
        return label
    }()

    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray01Dark
        label.numberOfLines = 0
        return label
    }()

    private let applyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .acpYellow
        button.setTitleColor(.gray06Dark, for: .normal)
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        return button
    }()

    // MARK: - Initialization

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        backgroundColor = .clear
        containerView.backgroundColor = .white

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(detailsLabel)
        containerView.addSubview(applyButton)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(Constants.Constraints.ContainerInsetVertical)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
        }

        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.DetailsOffsetTop)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
        }

        applyButton.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetTop)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.bottom.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
        }
    }

    // MARK: - Presenting

    func present() {
        titleLabel.text = Constants.Text.Title
        detailsLabel.text = Constants.Text.Details
        applyButton.setTitle(Constants.Text.Apply, for: .normal)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ContainerInsetVertical: CGFloat = 20

            static let ContentInsetVertical: CGFloat = 30
            static let ContentInsetHorizontal: CGFloat = 35

            static let DetailsOffsetTop: CGFloat = 10

            static let ButtonOffsetTop: CGFloat = 20
            static let ButtonHeight: CGFloat = 46
            static let ButtonCornerRadius: CGFloat = 10
        }

        struct Text {
            static let Title = "You are now eligible for ACP!"
            static let Details = """
                The benefit provides a discount of up to $30 per month toward internet service for
                eligible households and up to $75 per month for households on qualifying Tribal lands.
                """
            static let Apply = "Apply for ACP"
        }
    }
}
