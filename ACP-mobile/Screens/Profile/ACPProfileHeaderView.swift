//
//  ACPProfileHeaderView.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 13. 10. 2022..
//

import UIKit
import SnapKit

protocol ACPProfileHeaderViewDelegate: AnyObject {
    func didTapPersonalInfo()
    func didTapSecurityInfo()
    func didTapLegalInfo()
}

class ACPProfileHeaderView: UIView {

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

    private let changeProfileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .coreBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        return button
    }()

    private let personalInfoButton = ACPProfileVerticalStackButton()
    private let securityButton = ACPProfileVerticalStackButton()
    private let legalButton = ACPProfileVerticalStackButton()

    // MARK: - Initialization

    weak var delegate: ACPProfileHeaderViewDelegate?

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
        setupStackButtons()
    }

    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(checkmarkImageView)
        addSubview(nameLabel)
        addSubview(isVerifiedLabel)
        addSubview(changeProfileButton)
        addSubview(personalInfoButton)
        addSubview(securityButton)
        addSubview(legalButton)
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
            make.bottom.equalTo(changeProfileButton.snp.top)
        }

        changeProfileButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.Constraints.ChangeProfileButtonTopOffset)
            make.left.equalTo(Constants.Constraints.ButtonLeftOffest)
            make.width.equalTo(Constants.Constraints.ButtonWidth)
            make.height.equalTo(Constants.Constraints.ButtonHeight)

        }

        personalInfoButton.snp.makeConstraints { make in
            make.top.equalTo(changeProfileButton.snp.bottom).offset(Constants.Constraints.StackButtonsTopOffest)
            make.left.equalTo(Constants.Constraints.ButtonLeftOffest)
            make.width.equalTo(Constants.Constraints.ButtonWidth)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }

        securityButton.snp.makeConstraints { make in
            make.top.equalTo(personalInfoButton.snp.bottom).offset(Constants.Constraints.VerifiedOffsetTop)
            make.left.equalTo(Constants.Constraints.ButtonLeftOffest)
            make.width.equalTo(Constants.Constraints.ButtonWidth)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }

        legalButton.snp.makeConstraints { make in
            make.top.equalTo(securityButton.snp.bottom).offset(Constants.Constraints.VerifiedOffsetTop)
            make.left.equalTo(Constants.Constraints.ButtonLeftOffest)
            make.width.equalTo(Constants.Constraints.ButtonWidth)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.bottom.equalToSuperview().inset(Constants.Constraints.VerticalButtonOffest)
        }
    }

    func setupStackButtons() {
        personalInfoButton.layer.borderWidth = 1.5
        personalInfoButton.layer.borderColor = UIColor.gray03Light.cgColor
        personalInfoButton.layer.cornerRadius = 10
        personalInfoButton.isUserInteractionEnabled = true

        securityButton.layer.borderWidth = 1.5
        securityButton.layer.borderColor = UIColor.gray03Light.cgColor
        securityButton.layer.cornerRadius = 10

        legalButton.layer.borderWidth = 1.5
        legalButton.layer.borderColor = UIColor.gray03Light.cgColor
        legalButton.layer.cornerRadius = 10

        let personalBtnGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(personalButtonPressed))
        let securityBtnGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(securityButtonPressed))
        let legalBtnGestgure: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(legalButtonPressed))

        personalInfoButton.addGestureRecognizer(personalBtnGesture)
        securityButton.addGestureRecognizer(securityBtnGesture)
        legalButton.addGestureRecognizer(legalBtnGestgure)
    }

    // MARK: - Presenting

    public func present(name: String, isVerified: Bool) {
        changeProfileButton.setTitle(Constants.Text.ButtonChangeProfilePicture, for: .normal)
        profileImageView.image = UIImage(named: "test_profile")
        nameLabel.text = name
        personalInfoButton.present(buttonTitle: "Personal Info", leftImageName: "account")
        securityButton.present(buttonTitle: "Security", leftImageName: "lock")
        legalButton.present(buttonTitle: "Legal", leftImageName: "document")

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

    @objc func personalButtonPressed(sender: AnyObject) {
        delegate?.didTapPersonalInfo()
    }

    @objc func securityButtonPressed(sender: AnyObject) {
        delegate?.didTapSecurityInfo()
    }

    @objc func legalButtonPressed(sender: AnyObject) {
        delegate?.didTapLegalInfo()
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

            static let ChangeProfileButtonTopOffset: CGFloat = 51
            static let ChangeProfileButtonLeftOffest: CGFloat = 35

            static let StackButtonsTopOffest: CGFloat = 30
            static let ButtonLeftOffest: CGFloat = 35
            static let ButtonHeight: CGFloat = 46
            static let ButtonWidth: CGFloat = 320
            static let ButtonCornerRadius: CGFloat = 10

            static let VerticalButtonOffest: CGFloat = 31
        }

        struct Text {
            static let Verified = "Verified Account"
            static let NotVerified = "Not Verified"
            static let ButtonChangeProfilePicture = "Change Picture"
        }
    }
}
