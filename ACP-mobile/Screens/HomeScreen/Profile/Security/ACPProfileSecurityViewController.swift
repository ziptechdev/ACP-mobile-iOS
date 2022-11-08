//
//  ACPProfileSecurityViewController.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 13. 10. 2022..
//

import UIKit

class ACPProfileSecurityViewController: UIViewController {

    // MARK: - Properties

    private var isSecureEntry = true

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.MainTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let emailSectionTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.EmailAddress
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let passwordSectionTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.PasswordSection
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var emailTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.EmailAddress
        return view
    }()

    private lazy var currentPasswordTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.CurrentPassword
        view.textField.isSecureTextEntry = isSecureEntry
        view.textField.addRightImage(named: "eye", imageColor: .gray01Light)
        return view
    }()

    private lazy var newPasswordTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.NewPassword
        view.textField.isSecureTextEntry = isSecureEntry
        view.textField.addRightImage(named: "eye", imageColor: .gray01Light)
        return view
    }()

    private lazy var confirmNewPasswordTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.ConfirmNewPassword
        view.textField.isSecureTextEntry = isSecureEntry
        view.textField.addRightImage(named: "eye", imageColor: .gray01Light)
        return view
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Text.SaveButtonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = Constants.Text.Title
        navigationController?.navigationBar.isHidden = false

    }
    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(emailSectionTitle)
        view.addSubview(emailTextField)
        view.addSubview(passwordSectionTitle)
        view.addSubview(currentPasswordTextField)
        view.addSubview(newPasswordTextField)
        view.addSubview(confirmNewPasswordTextField)
        view.addSubview(saveButton)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Constraints.TitleTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
        }

        emailSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.EmailSectionTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailSectionTitle.snp.bottom).offset(Constants.Constraints.EmailTextFieldTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        passwordSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Constants.Constraints.PasswordSectionTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
        }

        currentPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordSectionTitle.snp.bottom).offset(Constants.Constraints.PasswordFieldTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(currentPasswordTextField.snp.bottom).offset(Constants.Constraints.NewPasswordTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        confirmNewPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(Constants.Constraints.ConfirmNewPasswordTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(confirmNewPasswordTextField.snp.bottom).offset(Constants.Constraints.ButtonTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }
    }

    // MARK: - Callbacks

    @objc func didTapButton() {
        print("save")
    }

    func focusTextField(_ view: ACPTextField) {
        view.textField.layer.borderColor = UIColor.coreBlue.cgColor
        view.textFieldImage?.tintColor = .gray06Dark
    }

    func unFocusTextField(_ view: ACPTextField) {
        view.textField.layer.borderColor = UIColor.gray03Light.cgColor
        view.textFieldImage?.tintColor = .gray03Light
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {

            static let LROffset = 35
            static let mainWidth = 320
            static let TitleTopOffset = 161

            static let EmailSectionTopOffset = 33
            static let EmailTextFieldTopOffset = 9

            static let PasswordSectionTopOffset = 31
            static let PasswordFieldTopOffset = 10
            static let NewPasswordTopOffset = 10
            static let ConfirmNewPasswordTopOffset = 10

            static let ButtonTopOffset = 30
            static let ButtonHeight: CGFloat = 46
            static let ButtonCornerRadius: CGFloat = 10
            static let ButtonOffsetVertical: CGFloat = 60

        }

        struct Text {
            static let Title = "Profile"
            static let MainTitle = "Security"
            static let EmailAddress = "Email Address"
            static let PasswordSection = "Password"
            static let CurrentPassword = "Current Password"
            static let NewPassword = "New Password"
            static let ConfirmNewPassword = "Confirm New Password"
            static let SaveButtonText = "Save"
        }
    }
}
