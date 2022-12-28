//
//  KYCPersonalInfoDetailsViewController.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit
import SnapKit

class KYCPersonalInfoDetailsViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: KYCRegistrationViewModel
    weak var delegate: TabMenuDelegate?

    private lazy var textFields: [TextInput] = [
        firstNameTextField, lastNameTextField, emailTextField, phoneTextField, passwordTextField,
        confirmTextField, ssnTextField
    ]

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
        label.attributedText = NSMutableAttributedString.subtitleString(key: "personal_info_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var firstNameTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "personal_info_first_name")
        view.textField.delegate = self
        return view
    }()

    private lazy var lastNameTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "personal_info_last_name")
        view.textField.delegate = self
        return view
    }()

    private lazy var emailTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "personal_info_email")
        view.textField.delegate = self
        return view
    }()

    private lazy var phoneTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "personal_info_phone")
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var passwordTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "personal_info_password")
        view.textField.delegate = self
        view.toggleSecureEntry()
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSecureEntry))
        view.textFieldImage?.addGestureRecognizer(tap)
        return view
    }()

    private lazy var confirmTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "personal_info_confirm")
        view.textField.delegate = self
        view.toggleSecureEntry()
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSecureEntry))
        view.textFieldImage?.addGestureRecognizer(tap)
        return view
    }()

    private lazy var ssnTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "personal_info_ssn")
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var nextButton: ImageButton = {
        let button = ImageButton(
            titleKey: "personal_info_btn",
            spacing: Constants.ButtonContentSpacing,
            cornerRadius: Constants.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.isUserInteractionEnabled = false
        button.backgroundColor = .lavenderGray
        button.translatesAutoresizingMaskIntoConstraints = false
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
        showValuesIfPresent()
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()

        infoLabel.delegate = self
    }

    private func addSubviews() {
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(firstNameTextField)
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
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalToSuperview().inset(Constants.ContentInsetVertical)
        }

        firstNameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.NameOffsetVertical)
        }

        lastNameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(firstNameTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(lastNameTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        phoneTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(emailTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(phoneTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        confirmTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        ssnTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(confirmTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(ssnTextField.snp.bottom).offset(Constants.ButtonOffsetVertical)
        }

        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(nextButton.snp.bottom).offset(Constants.InfoOffsetVertical)
            make.bottom.equalToSuperview().inset(Constants.InfoInsetVertical)
        }
    }

    private func showValuesIfPresent() {
        firstNameTextField.textField.text = viewModel.model.firstName
        lastNameTextField.textField.text = viewModel.model.lastName
        emailTextField.textField.text = viewModel.model.email
        phoneTextField.textField.text = viewModel.model.phoneNumber
        passwordTextField.textField.text = viewModel.model.password
        ssnTextField.textField.text = viewModel.model.ssn
        
        checkValues()
    }

    private func checkValues() {
        let isEnabled = textFields.allSatisfy({ !$0.isEmpty })

        nextButton.isUserInteractionEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }

    // MARK: - Callback

    @objc func toggleSecureEntry() {
        passwordTextField.toggleSecureEntry()
        confirmTextField.toggleSecureEntry()
    }

    @objc func didTapButton() {
        guard checkPasswords() else {
            return
        }

        viewModel.model.firstName = firstNameTextField.text
        viewModel.model.lastName = lastNameTextField.text
        viewModel.model.email = emailTextField.text
        viewModel.model.phoneNumber = phoneTextField.text
        viewModel.model.password = passwordTextField.text
        viewModel.model.ssn = ssnTextField.text

        delegate?.didTapNextButton()
    }

    func checkPasswords() -> Bool {
        let passwordsMatch = passwordTextField.text == confirmTextField.text

        if !passwordsMatch {
            showError(true)
        }

        return passwordsMatch
    }

    func showError(_ show: Bool) {
        if show {
            confirmTextField.showError(message: "Passwords do not match")
        } else {
            confirmTextField.hideError()
        }
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
        static let InfoInsetVertical: CGFloat = 60
    }
}

// MARK: - TermsAndPrivacyLabelDelegate

extension KYCPersonalInfoDetailsViewController: TermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        viewModel.openTerms()
    }

    func didTapPrivacy() {
        viewModel.openPrivacyPolicy()
    }
}

// MARK: - UITextFieldDelegate

extension KYCPersonalInfoDetailsViewController: UITextFieldDelegate {
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
        showError(false)

        checkValues()
    }
}

// MARK: - ToolbarDelegate

extension KYCPersonalInfoDetailsViewController: ToolbarDelegate {
    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}
