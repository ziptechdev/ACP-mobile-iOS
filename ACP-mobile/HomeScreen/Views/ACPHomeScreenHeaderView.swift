//
//  ACPHomeScreenHeaderView.swift
//  ACP-mobile
//
//  Created by Adi on 28/09/2022.
//

import UIKit
import SnapKit

class ACPHomeScreenHeaderView: UIView {

    // MARK: - Views

    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.Constraints.ImageCornerRadius
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let checkmarkImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.Constraints.CheckmarkCornerRadius
        view.layer.masksToBounds = true
        view.contentMode = .center
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.textColor = .gray06Dark
        return label
    }()

    private let isVerifiedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .gray01Light
        return label
    }()

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)

        setupUI()

        present(name: "John Doe", isVerified: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .white

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(checkmarkImageView)
        addSubview(nameLabel)
        addSubview(isVerifiedLabel)
    }

    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Constraints.ImageSize)
            make.top.equalToSuperview().inset(Constants.Constraints.ImageInsetTop)
            make.centerX.equalToSuperview()
        }

        checkmarkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Constraints.CheckmarkSize)
            make.right.equalTo(profileImageView.snp.right).offset(Constants.Constraints.CheckmarkOffset)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(Constants.Constraints.CheckmarkOffset)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(Constants.Constraints.NameOffsetTop)
            make.centerX.equalToSuperview()
        }

        isVerifiedLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.Constraints.VerifiedOffsetTop)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.Constraints.VerifiedInsetBot)
        }
    }

    // MARK: - Presenting

    public func present(name: String, isVerified: Bool) {
        profileImageView.image = UIImage(named: "test_profile")
        nameLabel.text = name

        if isVerified {
            isVerifiedLabel.text = Constants.Text.Verified
            checkmarkImageView.image = UIImage(named: "checkmark")
            checkmarkImageView.backgroundColor = .successGreen
        } else {
            isVerifiedLabel.text = Constants.Text.NotVerified
            checkmarkImageView.image = UIImage(named: "checkmark")
            checkmarkImageView.backgroundColor = .warningRed
        }
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ImageInsetTop: CGFloat = 50
            static let ImageSize: CGFloat = 96
            static let ImageCornerRadius: CGFloat = 30

            static let CheckmarkSize: CGFloat = 32
            static let CheckmarkOffset: CGFloat = 10
            static let CheckmarkCornerRadius: CGFloat = 10

            static let NameOffsetTop: CGFloat = 20

            static let VerifiedOffsetTop: CGFloat = 10
            static let VerifiedInsetBot: CGFloat = 30
        }

        struct Text {
            static let Verified = "Verified Account"
            static let NotVerified = "Not Verified"
        }
    }
}
