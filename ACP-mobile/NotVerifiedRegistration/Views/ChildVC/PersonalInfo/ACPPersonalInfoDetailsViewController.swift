//
//  ACPPersonalInfoDetailsViewController.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit
import SnapKit

class ACPPersonalInfoDetailsViewController: UIViewController {

    // MARK: - Properties

    private var isSecureEntry = true
    weak var delegate: ACPTabMenuDelegate?

    // MARK: - Views

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.Subtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray01Light
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var nameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.FirstName
        view.textField.delegate = self
        return view
    }()

    private lazy var lastNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.LastName
        view.textField.delegate = self
        return view
    }()

    private lazy var emailTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.Email
        view.textField.delegate = self
        return view
    }()

    private lazy var phoneTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.PhoneNumber
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var passwordTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.Password
        view.textField.delegate = self
        view.textField.isSecureTextEntry = isSecureEntry
        view.textField.addRightImage(named: "eye", imageColor: .gray01Light)
        return view
    }()

    private lazy var confirmTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.ConfirmPassword
        view.textField.delegate = self
        view.textField.isSecureTextEntry = isSecureEntry
        view.textField.addRightImage(named: "eye", imageColor: .gray01Light)
        return view
    }()

    private lazy var ssnTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.SSN
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var nextButton: ACPImageButton = {
        let button = ACPImageButton(
            spacing: Constants.Constraints.ButtonContentSpacing,
            cornerRadius: Constants.Constraints.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Text.Next, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private let infoLabel = ACPTermsAndPrivacyLabel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(emailTextField)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(confirmTextField)
        contentView.addSubview(ssnTextField)
        contentView.addSubview(nextButton)
        contentView.addSubview(infoLabel)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.width.centerX.top.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.width.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
        }

        nameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.NameOffsetVertical)
        }

        lastNameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(nameTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(lastNameTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        phoneTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(emailTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(phoneTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        confirmTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        ssnTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(confirmTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(ssnTextField.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }

        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(nextButton.snp.bottom).offset(Constants.Constraints.InfoOffsetVertical)
            make.bottom.equalToSuperview().inset(Constants.Constraints.InfoInsetVertical)
        }
    }

    // MARK: - Callback

    @objc func didTapButton() {
        delegate?.didTapNextButton()
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ContentInsetVertical: CGFloat = 30
            static let ContentInsetHorizontal: CGFloat = 35

            static let NameOffsetVertical: CGFloat = 30

            static let TextFieldOffsetVertical: CGFloat = 10

            static let ButtonHeight: CGFloat = 46
            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10
            static let ButtonOffsetVertical: CGFloat = 60

            static let InfoOffsetVertical: CGFloat = 30
            static let InfoInsetVertical: CGFloat = 60
        }

        struct Text {
            static let Subtitle = "Enter personal information below that will be associated with your account."
            static let FirstName = "First Name"
            static let LastName = "Last Name"
            static let Email = "Email Address"
            static let PhoneNumber = "Phone Number"
            static let Password = "Password"
            static let ConfirmPassword = "Confirm Password"
            static let SSN = "SSN (Social Security Number)"
            static let Next = "Next"
        }
    }
}

// MARK: - UITextFieldDelegate

extension ACPPersonalInfoDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField.textField {
            lastNameTextField.textField.becomeFirstResponder()
        } else if textField == lastNameTextField.textField {
            emailTextField.textField.becomeFirstResponder()
        } else if textField == emailTextField.textField {
            phoneTextField.textField.becomeFirstResponder()
        } else if textField == phoneTextField.textField {
            passwordTextField.textField.becomeFirstResponder()
        } else if textField == passwordTextField.textField {
            confirmTextField.textField.becomeFirstResponder()
        } else if textField == confirmTextField.textField {
            ssnTextField.textField.becomeFirstResponder()
        } else {
            ssnTextField.textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - ACPToolbarDelegate

extension ACPPersonalInfoDetailsViewController: ACPToolbarDelegate {
    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}
