//
//  ACPVerifiedRegistrationViewController.swift
//  ACP-mobile
//
//  Created by Adi on 04/10/2022.
//

import UIKit
import SnapKit

class ACPVerifiedRegistrationViewController: UIViewController {

    // MARK: - Properties

    private var isSecureEntry = true

    // MARK: - Views

    private let registerImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "new_account")
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "verified_register_title")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        // TODO: Set the name
        label.attributedText = NSMutableAttributedString.subtitleString(key: "verified_register_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var emailTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "verified_register_email")
        view.textField.delegate = self
        return view
    }()

    private lazy var passwordTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "verified_register_password")
        view.textField.delegate = self
        view.toggleSecureEntry(isSecureEntry)
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSecureEntry))
        view.textFieldImage?.addGestureRecognizer(tap)
        return view
    }()

    private lazy var confirmTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "verified_register_confirm")
        view.textField.delegate = self
        view.toggleSecureEntry(isSecureEntry)
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSecureEntry))
        view.textFieldImage?.addGestureRecognizer(tap)
        return view
    }()

    private let passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "password_not_matched")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .red
        label.isHidden = true
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = .lavenderGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "verified_register_btn")
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private let infoLabel = ACPTermsAndPrivacyLabel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = .localizedString(key: "verified_register_page_title")
        navigationController?.navigationBar.isHidden = false

        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()

        
    }

    private func addSubviews() {
        view.addSubview(registerImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmTextField)
        view.addSubview(passwordErrorLabel)
        view.addSubview(registerButton)
        view.addSubview(infoLabel)
    }

    private func setupConstraints() {
        registerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.ContentInsetVertical)
            make.width.height.equalTo(Constants.Constraints.ImageSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(registerImageView.snp.bottom).offset(Constants.Constraints.ContentInsetVertical)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffsetVertical)
        }

        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.EmailOffsetVertical)
        }

        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(emailTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        confirmTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        passwordErrorLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(confirmTextField.snp.bottom).offset(Constants.Constraints.InfoLabelInsetY)
        }

        registerButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(confirmTextField.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }

        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.InfoLabelInsetY)
        }
    }

    // MARK: - Callbacks

    @objc func toggleSecureEntry() {
        isSecureEntry = !isSecureEntry

        passwordTextField.toggleSecureEntry(isSecureEntry)
        confirmTextField.toggleSecureEntry(isSecureEntry)
    }

    @objc func didTapButton() {
        let targetVC = ACPRegistrationCompleteViewController()
        navigationController?.pushViewController(targetVC, animated: true)
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
            static let ContentInsetVertical: CGFloat = 30
            static let ContentInsetHorizontal: CGFloat = 35

            static let ImageSize: CGFloat = 128

            static let SubtitleOffsetVertical: CGFloat = 10

            static let EmailOffsetVertical: CGFloat = 30
            static let TextFieldOffsetVertical: CGFloat = 10

            static let ButtonHeight: CGFloat = 46
            static let ButtonCornerRadius: CGFloat = 10
            static let ButtonOffsetVertical: CGFloat = 60

            static let InfoLabelInsetY: CGFloat = 5
        }
    }
}

// MARK: - UITextFieldDelegate

extension ACPVerifiedRegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField.textField {
            passwordTextField.textField.becomeFirstResponder()
        } else if textField == passwordTextField.textField {
            confirmTextField.textField.becomeFirstResponder()
        } else {
            confirmTextField.textField.resignFirstResponder()
        }
        return true
    }
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == emailTextField.textField {
//            focusTextField(emailTextField)
//        } else if textField == passwordTextField.textField {
//            focusTextField(passwordTextField)
//        } else {
//            focusTextField(confirmTextField)
//        }
//        return true
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField == emailTextField.textField {
//            unFocusTextField(emailTextField)
//        } else if textField == passwordTextField.textField {
//            unFocusTextField(passwordTextField)
//        } else {
//            unFocusTextField(confirmTextField)
//        }
//        return true
//    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let email = emailTextField.textField.text,
              let password = passwordTextField.textField.text,
              let confirmPass = confirmTextField.textField.text,
              !(password == "" && confirmPass == "")
        else { return }

        passwordErrorLabel.isHidden = password == confirmPass

        guard password == confirmPass else { return }

        let isEnabled = !(email == "")

        registerButton.isUserInteractionEnabled = isEnabled
        registerButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }
}
