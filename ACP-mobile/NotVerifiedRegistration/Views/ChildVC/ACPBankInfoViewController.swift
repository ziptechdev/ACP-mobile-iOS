//
//  ACPBankInfoViewController.swift
//  ACP-mobile
//
//  Created by Adi on 19/10/2022.
//

import UIKit
import SnapKit

class ACPBankInfoViewController: UIViewController {

	// MARK: - Properties

    weak var delegate: ACPTabMenuDelegate?

    // MARK: - Views

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Constants.Text.Subtitle"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray01Light
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var bankNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = "Constants.Text.FirstName"
        view.textField.delegate = self
        return view
    }()

    private lazy var bankNumberTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = "Constants.Text.LastName"
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var accountHolderTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = "Constants.Text.Email"
        view.textField.delegate = self
        return view
    }()

    private lazy var accountNumberTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = "Constants.Text.PhoneNumber"
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var expirationTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = "Constants.Text.Password"
        view.textField.delegate = self
        return view
    }()

    private lazy var completeButton: ACPImageButton = {
        let button = ACPImageButton(
            spacing: Constants.Constraints.ButtonContentSpacing,
            cornerRadius: Constants.Constraints.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Constants.Text.Next", for: .normal)
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
        view.addSubview(subtitleLabel)
        view.addSubview(bankNameTextField)
        view.addSubview(bankNumberTextField)
        view.addSubview(accountHolderTextField)
        view.addSubview(accountNumberTextField)
        view.addSubview(expirationTextField)
        view.addSubview(completeButton)
        view.addSubview(infoLabel)
    }

    private func setupConstraints() {
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
        }

        bankNameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.NameOffsetVertical)
        }

        bankNumberTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(bankNameTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        accountHolderTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(bankNumberTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        accountNumberTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(accountHolderTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        expirationTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(accountNumberTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        completeButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(expirationTextField.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }

        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(completeButton.snp.bottom).offset(Constants.Constraints.InfoOffsetVertical)
            make.bottom.equalToSuperview().inset(Constants.Constraints.InfoInsetVertical)
        }
    }

    // MARK: - Callback

    @objc func didTapButton() {
        delegate?.didTapActionButton()
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
    }
}

// MARK: - UITextFieldDelegate

extension ACPBankInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bankNameTextField.textField {
            bankNumberTextField.textField.becomeFirstResponder()
        } else if textField == bankNumberTextField.textField {
            accountHolderTextField.textField.becomeFirstResponder()
        } else if textField == accountHolderTextField.textField {
            accountNumberTextField.textField.becomeFirstResponder()
        } else if textField == accountNumberTextField.textField {
            expirationTextField.textField.becomeFirstResponder()
        } else {
            expirationTextField.textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - ACPToolbarDelegate

extension ACPBankInfoViewController: ACPToolbarDelegate {
    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}
