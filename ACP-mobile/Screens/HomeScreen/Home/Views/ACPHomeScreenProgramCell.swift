//
//  ACPHomeScreenProgramCell.swift
//  ACP-mobile
//
//  Created by Adi on 29/09/2022.
//

import UIKit
import SnapKit

class ACPHomeScreenProgramCell: UITableViewCell {

    // MARK: - Views

    private let programNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .gray06Dark
        return label
    }()

    private let programImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.contentMode = .center
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let statusButton: ImageButton = {
        let button = ImageButton(
            horizontal: Constants.Constraints.StatusButtonContentInsetX,
            spacing: Constants.Constraints.StatusButtonContentSpacing,
            cornerRadius: Constants.Constraints.StatusButtonCornerRadius,
            imageName: "checkmark",
            isLeft: true
        )
        button.backgroundColor = .acpYellow
        return button
    }()

    private let programDetailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray01Light
        label.numberOfLines = 0
        return label
    }()

    private let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .coreBlue
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        return button
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        backgroundColor = .white

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(programNameLabel)
        contentView.addSubview(programImageView)
        contentView.addSubview(statusButton)
        contentView.addSubview(programDetailsLabel)
        contentView.addSubview(actionButton)
    }

    private func setupConstraints() {
        programNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
            make.left.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.right.equalTo(programImageView.snp.left).inset(Constants.Constraints.ContentInsetHorizontal)
        }

        programImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.Constraints.LogoSize)
            make.top.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
            make.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
        }

        statusButton.snp.makeConstraints { make in
            make.bottom.equalTo(programImageView)
            make.left.equalTo(programNameLabel)
            make.height.equalTo(Constants.Constraints.StatusButtonHeight)
        }

        programDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(statusButton.snp.bottom).offset(Constants.Constraints.DetailsOffsetTop)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
        }

        actionButton.snp.makeConstraints { make in
            make.top.equalTo(programDetailsLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetTop)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.bottom.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
        }
    }

    // MARK: - Presenting

    func present(name: String) {
        programNameLabel.text = name
        programImageView.image = UIImage(named: "program_logo")
        programDetailsLabel.text = Constants.Text.Details
        statusButton.setTitle(titleKey: Constants.Text.Eligible, font: .systemFont(ofSize: 11, weight: .bold))
        actionButton.setTitle(titleKey: Constants.Text.Apply)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ContentInsetVertical: CGFloat = 30
            static let ContentInsetHorizontal: CGFloat = 35

            static let LogoSize: CGFloat = 82

            static let StatusButtonHeight: CGFloat = 29
            static let StatusButtonCornerRadius: CGFloat = 5
            static let StatusButtonContentSpacing: CGFloat = 4
            static let StatusButtonContentInsetX: CGFloat = 20

            static let ButtonOffsetTop: CGFloat = 20
            static let ButtonHeight: CGFloat = 46
            static let ButtonCornerRadius: CGFloat = 10

            static let DetailsOffsetTop: CGFloat = 10
        }

        struct Text {
            static let Details = """
                Medicaid provides health coverage to low-income people and is one of the largest
                payers for...
                """
            static let Eligible = "Eligible"
            static let Apply = "Apply"
        }
    }
}
