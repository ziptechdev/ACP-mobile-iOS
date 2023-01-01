//
//  KYCBankInfoViewController.swift
//  ACP-mobile
//
//  Created by Adi on 19/10/2022.
//

import UIKit
import SnapKit

class KYCBankInfoViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: KYCRegistrationViewModel
    weak var delegate: TabMenuDelegate?

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

    private lazy var bankNameTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "bank_info_bank_name")
        view.textField.delegate = self
        return view
    }()

    private lazy var bankNumberTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "bank_info_bank_number")
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var accountHolderTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "bank_info_acc_name")
        view.textField.delegate = self
        return view
    }()

    private lazy var accountNumberTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "bank_info_acc_number")
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var expirationTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "bank_info_expiration")
        view.textField.delegate = self
        return view
    }()

    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = .lavenderGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "bank_info_btn")
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private let infoLabel = TermsAndPrivacyLabel()

    // MARK: - Initialization

    init(viewModel: KYCRegistrationViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        hideKeyboardWhenTappedAround()
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
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalToSuperview().inset(Constants.ContentInsetVertical)
        }

        bankNameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.NameOffsetVertical)
        }

        bankNumberTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(bankNameTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        accountHolderTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(bankNumberTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        accountNumberTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(accountHolderTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        expirationTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(accountNumberTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        completeButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(expirationTextField.snp.bottom).offset(Constants.ButtonOffsetVertical)
        }

        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.InfoInsetVertical)
        }
    }

    private func showValuesIfPresent() {
        bankNameTextField.textField.text = viewModel.model.bankName
        bankNumberTextField.textField.text = viewModel.model.bankNumber
        accountHolderTextField.textField.text = viewModel.model.accountHolderName
        accountNumberTextField.textField.text = viewModel.model.accountNumber
        expirationTextField.textField.text = viewModel.model.expirationDate

        checkValues()
    }

    private func checkValues() {
        let isEnabled = textFields.allSatisfy({ !$0.isEmpty })

        completeButton.isUserInteractionEnabled = isEnabled
        completeButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }

    // MARK: - Callback

    @objc func didTapButton() {
        viewModel.model.bankName = bankNameTextField.text
        viewModel.model.bankNumber = bankNumberTextField.text
        viewModel.model.accountHolderName = accountHolderTextField.text
        viewModel.model.accountNumber = accountNumberTextField.text
        viewModel.model.expirationDate = expirationTextField.text

        delegate?.didTapActionButton()
    }

    // MARK: - Constants

    private struct Constants {
        static let ContentInsetVertical: CGFloat = 30
        static let ContentInsetHorizontal: CGFloat = 35

        static let NameOffsetVertical: CGFloat = 30

        static let TextFieldOffsetVertical: CGFloat = 10

        static let ButtonHeight: CGFloat = 46
        static let ButtonContentSpacing: CGFloat = 10
        static let ButtonCornerRadius: CGFloat = 10
        static let ButtonOffsetVertical: CGFloat = 60

        static let InfoOffsetVertical: CGFloat = 30
        static let InfoInsetVertical: CGFloat = 5
    }
}

// MARK: - TermsAndPrivacyLabelDelegate

extension KYCBankInfoViewController: TermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        viewModel.openTerms()
    }

    func didTapPrivacy() {
        viewModel.openPrivacyPolicy()
    }
}

// MARK: - UITextFieldDelegate

extension KYCBankInfoViewController: UITextFieldDelegate {
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
        checkValues()
    }
}

// MARK: - ToolbarDelegate

extension KYCBankInfoViewController: ToolbarDelegate {
    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}
