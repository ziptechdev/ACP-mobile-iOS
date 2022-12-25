//
//  LoginViewController.swift
//  ACP-mobile
//
//  Created by Adi on 30/10/2022.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    // MARK: - Properties

    private var viewModel: LoginViewModel

    private lazy var textFields: [TextInput] = [
        emailTextField, passwordTextField
    ]

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "login_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(key: "login_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var emailTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "login_email")
        view.textField.delegate = self
        return view
    }()

    private lazy var passwordTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "login_password")
        view.textField.delegate = self
        view.toggleSecureEntry(viewModel.isSecureEntry)
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSecureEntry))
        view.textFieldImage?.addGestureRecognizer(tap)
        return view
    }()

    private let forgotLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "login_forgot")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .coreBlue
        label.textAlignment = .right
        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = .lavenderGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "login_btn")
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private let infoLabel = TermsAndPrivacyLabel()

    // MARK: - Initialization

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        viewModel.dismiss()
    }

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = .localizedString(key: "login_page_title")
        navigationController?.navigationBar.isHidden = false

        if viewModel.showCloseButton {
            setupRightNavigationBarButton()
            navigationItem.leftBarButtonItem = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()

        infoLabel.delegate = self
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotLabel)
        view.addSubview(loginButton)
        view.addSubview(infoLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.ContentInsetVertical)
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

        forgotLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constants.TextFieldOffsetVertical)
        }

        loginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.bottom.equalTo(infoLabel.snp.top).offset(-Constants.ButtonOffsetVertical)
        }

        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.InfoLabelInsetY)
        }
    }

    // MARK: - Callbacks

    @objc func toggleSecureEntry() {
        viewModel.isSecureEntry.toggle()
        passwordTextField.toggleSecureEntry(viewModel.isSecureEntry)
    }

    @objc func didTapButton() {
        viewModel.login(
            email: emailTextField.text,
            password: passwordTextField.text
        )
    }

    // MARK: - Constants

    private struct Constants {
        static let ContentInsetVertical: CGFloat = 80
        static let ContentInsetHorizontal: CGFloat = 35

        static let SubtitleOffsetVertical: CGFloat = 15

        static let EmailOffsetVertical: CGFloat = 50
        static let TextFieldOffsetVertical: CGFloat = 10

        static let ButtonHeight: CGFloat = 46
        static let ButtonCornerRadius: CGFloat = 10
        static let ButtonOffsetVertical: CGFloat = 90

        static let InfoLabelInsetY: CGFloat = 5
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
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

        loginButton.isUserInteractionEnabled = isEnabled
        loginButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }
}

// MARK: - TermsAndPrivacyLabelDelegate

extension LoginViewController: TermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        viewModel.openTerms()
    }

    func didTapPrivacy() {
        viewModel.openPrivacyPolicy()
    }
}
