//
//  KYCVerifyEmailViewController.swift
//  ACP-mobile
//
//  Created by Adi on 11/10/2022.
//

import UIKit
import SnapKit

class KYCVerifyEmailViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: KYCPersonalInfoViewModel
    private var code = ""

    // MARK: - Views

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "x_mark")?.withRenderingMode(.alwaysTemplate)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.CancelButtonRadius
        button.backgroundColor = .gray06Light
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .gray01Dark
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "verify_email_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(
            key: "verify_email_subtitle",
            isCenter: true
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        return label
    }()

    private let codeView: KYCVerifyEmailCodeView = {
        let view = KYCVerifyEmailCodeView()

        return view
    }()

    private lazy var resendCodeLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedText()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        label.addGestureRecognizer(tap)
        return label
    }()

    private lazy var keyboardView: KYCVerifyEmailKeyboardView = {
        let view = KYCVerifyEmailKeyboardView()
        view.delegate = self
        return view
    }()

    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "verify_email_btn")
        button.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization

    init(viewModel: KYCPersonalInfoViewModel) {
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
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(cancelButton)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(codeView)
        view.addSubview(resendCodeLabel)
        view.addSubview(keyboardView)
        view.addSubview(confirmButton)
    }

    private func setupConstraints() {
        cancelButton.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.CancelButtonSize)
            make.top.equalToSuperview().inset(Constants.CancelButtonInsetY)
            make.right.equalToSuperview().inset(Constants.CancelButtonInsetX)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(Constants.TitleOffset)
            make.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.SubtitleOffset)
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
        }

        codeView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.CodeViewOffset)
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
        }

        resendCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(codeView.snp.bottom).offset(Constants.ResendLabelOffset)
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
        }

        keyboardView.snp.makeConstraints { make in
            make.top.equalTo(resendCodeLabel.snp.bottom).offset(Constants.KeyboardViewInsetY)
            make.left.right.equalToSuperview().inset(Constants.KeyboardViewInsetX)
        }

        confirmButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(keyboardView.snp.bottom).offset(Constants.ButtonOffsetVertical)
        }
    }

    private func attributedText() -> NSMutableAttributedString {
        let string: NSMutableAttributedString = .localizedString(key: "verify_email_no_code")
        let highlightRange = string.range(of: .localizedString(key: "verify_email_highlight"))

        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular))
        string.addAttribute(.paragraphStyle, value: NSMutableParagraphStyle.center)
        string.addAttribute(.foregroundColor, value: UIColor.gray06Dark)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: highlightRange)

        return string
    }

    // MARK: - Callbacks

    @objc func didTapCancel() {
        dismiss(animated: true)
    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let string: String = .localizedString(key: "verify_email_no_code")
        let highlightRange = string.range(of: .localizedString(key: "verify_email_highlight"))

        if sender.didTapAttributedTextInLabel(label: resendCodeLabel, inRange: highlightRange) {
            viewModel.resendEmailCode()
        }
    }

    @objc func didTapConfirm() {
        viewModel.confirmCode(code)
    }

    // MARK: - Constants

    private struct Constants {
        static let ContentInsetHorizontal: CGFloat = 35

        static let CancelButtonInsetY: CGFloat = 28
        static let CancelButtonInsetX: CGFloat = 23
        static let CancelButtonRadius: CGFloat = 10
        static let CancelButtonSize: CGFloat = 36

        static let TitleOffset: CGFloat = 20
        static let SubtitleOffset: CGFloat = 20
        static let CodeViewOffset: CGFloat = 30
        static let ResendLabelOffset: CGFloat = 20
        static let KeyboardViewInsetY: CGFloat = 20
        static let KeyboardViewInsetX: CGFloat = 60

        static let ButtonHeight: CGFloat = 46
        static let ButtonCornerRadius: CGFloat = 10
        static let ButtonOffsetVertical: CGFloat = 30
    }
}

// MARK: - KYCVerifyEmailKeyboardViewDelegate

extension KYCVerifyEmailViewController: KYCVerifyEmailKeyboardViewDelegate {
    func didPressKey(key: String) {
        code = String((code + key).prefix(5))
        codeView.setText(code: code)
    }

    func didPressDelete() {
        _ = code.popLast()
        codeView.setText(code: code)
    }
}
