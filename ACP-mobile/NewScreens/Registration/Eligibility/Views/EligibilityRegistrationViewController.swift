//
//  EligibilityRegistrationViewController.swift
//  ACP-mobile
//
//  Created by Adi on 04/10/2022.
//

import UIKit
import SnapKit

class EligibilityRegistrationViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: EligibilityRegistrationViewModel

    private lazy var textFields: [TextInput] = [
        emailTextField, passwordTextField, confirmTextField
    ]

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
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray01Light
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var emailTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "verified_register_email")
        view.textField.delegate = self
        return view
    }()

    private lazy var passwordTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "verified_register_password")
        view.textField.delegate = self
        view.toggleSecureEntry()
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSecureEntry))
        view.textFieldImage?.addGestureRecognizer(tap)
        return view
    }()

    private lazy var confirmTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "verified_register_confirm")
        view.textField.delegate = self
        view.toggleSecureEntry()
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSecureEntry))
        view.textFieldImage?.addGestureRecognizer(tap)
        return view
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = .lavenderGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "verified_register_btn")
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private let infoLabel = TermsAndPrivacyLabel()

    // MARK: - Initialization

    init(viewModel: EligibilityRegistrationViewModel) {
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
        viewModel.errorCompletion = showServerError
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = .localizedString(key: "verified_register_page_title")
        navigationController?.navigationBar.isHidden = false

        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
        hideKeyboardWhenTappedAround()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()

        subtitleLabel.text = .formatLocalizedString(
            key: "verified_register_subtitle",
            values: viewModel.firstName
        )
    }

    private func addSubviews() {
        view.addSubview(registerImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmTextField)
        view.addSubview(registerButton)
        view.addSubview(infoLabel)
    }

    private func setupConstraints() {
        registerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.ContentInsetVertical)
            make.width.height.equalTo(Constants.ImageSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(registerImageView.snp.bottom).offset(Constants.ContentInsetVertical)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.SubtitleOffsetVertical)
        }

        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.EmailOffsetVertical)
        }

        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(emailTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        confirmTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        registerButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(confirmTextField.snp.bottom).offset(Constants.ButtonOffsetVertical)
        }

        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.InfoLabelInsetY)
        }
    }

    // MARK: - Callbacks

    @objc func toggleSecureEntry() {
        passwordTextField.toggleSecureEntry()
        confirmTextField.toggleSecureEntry()
    }

    @objc func didTapButton() {
        guard checkPasswords() else {
            return
        }

        viewModel.register(
            email: emailTextField.text,
            password: passwordTextField.text
        )
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

    func showServerError() {
        UIAlertController.showErrorAlert(message: "Server error", from: self)
    }

    // MARK: - Constants

    private struct Constants {
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

// MARK: - UITextFieldDelegate

extension EligibilityRegistrationViewController: UITextFieldDelegate {
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

        let isEnabled = textFields.allSatisfy({ !$0.isEmpty })

        registerButton.isUserInteractionEnabled = isEnabled
        registerButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }
}
