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

    private lazy var textFields: [TextInput] = [
        bankNameTextField, bankNumberTextField, accountHolderTextField, accountNumberTextField, expirationTextField
    ]

    // MARK: - Views

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(key: "bank_info_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var bankNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "bank_info_bank_name")
        view.textField.delegate = self
        return view
    }()

    private lazy var bankNumberTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "bank_info_bank_number")
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var accountHolderTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "bank_info_acc_name")
        view.textField.delegate = self
        return view
    }()

    private lazy var accountNumberTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "bank_info_acc_number")
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var expirationTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "bank_info_expiration")
        view.textField.delegate = self
        return view
    }()

    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "bank_info_btn")
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

        infoLabel.delegate = self
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

// MARK: - ACPTermsAndPrivacyLabelDelegate

extension ACPBankInfoViewController: ACPTermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        // TODO: Add link
    }

    func didTapPrivacy() {
        // TODO: Add link
    }
}

// MARK: - UITextFieldDelegate

extension ACPBankInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentIndex = textFields.firstIndex(where: { $0.textField == textField }) else {
            return true
        }

        let nextIndex = currentIndex.advanced(by: 1)

        if nextIndex < textFields.count {
            textFields[nextIndex].textField.becomeFirstResponder()
        } else if nextIndex == textFields.count {
            textFields[currentIndex].textField.resignFirstResponder()
        }

        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        let isEnabled = textFields.allSatisfy({ !$0.isEmpty })

        completeButton.isUserInteractionEnabled = isEnabled
        completeButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }
}

// MARK: - ACPToolbarDelegate

extension ACPBankInfoViewController: ACPToolbarDelegate {
    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}
