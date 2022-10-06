//
//  EgibilityCheckView.swift
//  ACP-mobile
//
//  Created by Abi  on 1. 10. 2022..
//

import UIKit

protocol EgibilityCheckDelegate: AnyObject {
    func didTapCheckEgibilityButton()
    func didTapCreateNewAccountButton()
    func didTapTextLink()
}

class EgibilityCheckView: UIView {

    // MARK: - Properties

    weak var delegate: EgibilityCheckDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coreBlue
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray01Light
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()

    let checkEgibilityButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.shadowColor = UIColor.lightGray.cgColor // UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 15.0
        button.layer.masksToBounds = false
        return button
    }()

    let createNewAccountButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.coreBlue, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.borderColor = UIColor.coreBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray01Light
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let buttonAndInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 30
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setUpConstraints()
        setText()

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        descriptionLabel.addGestureRecognizer(tap)
        descriptionLabel.attributedText = attributedInfoText()

        checkEgibilityButton.addTarget(self, action: #selector(checkEgibilityTapped), for: .touchUpInside)
        createNewAccountButton.addTarget(self, action: #selector(createNewAccountTapped), for: .touchUpInside)

    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func addSubviews() {
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(descriptionLabel)

        buttonAndInfoStackView.addArrangedSubview(checkEgibilityButton)
        buttonAndInfoStackView.addArrangedSubview(createNewAccountButton)
        buttonAndInfoStackView.addArrangedSubview(infoLabel)

        addSubview(textStackView)
        addSubview(buttonAndInfoStackView)
    }

    private func setUpConstraints() {

        createNewAccountButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }

        checkEgibilityButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }

        textStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(Constants.Constraints.TopConstant)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }

        buttonAndInfoStackView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom).inset(Constants.Constraints.BottomButtonConstant)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }

    }

    @objc func checkEgibilityTapped(sender: UIButton!) {
        delegate?.didTapCheckEgibilityButton()
    }

    @objc func createNewAccountTapped(sender: UIButton!) {
        delegate?.didTapCreateNewAccountButton()
    }

    private func setText() {

        titleLabel.text = Constants.Text.titleLabelEgibilityText
        descriptionLabel.text = Constants.Text.egibilityCheckText
        infoLabel.text = Constants.Text.personalNoteInfoText
        checkEgibilityButton.setTitle(Constants.Text.checkEgTextButton, for: .normal)
        createNewAccountButton.setTitle(Constants.Text.newAccountTextButton, for: .normal)

    }
    private func attributedInfoText() -> NSMutableAttributedString {
        let info =  Constants.Text.egibilityCheckText as NSString
        let fullRange = NSRange(location: 0, length: info.length)
        let markRange = info.range(of: Constants.Text.Terms)

        let string = NSMutableAttributedString(string: Constants.Text.egibilityCheckText)
        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular), range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.gray01Light, range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: markRange)

        return string

    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {

        guard let sender = sender else {
            return
        }
        let info = Constants.Text.egibilityCheckText as NSString
        let termsRange = info.range(of: Constants.Text.Terms)

        if sender.didTapAttributedTextInLabel(label: descriptionLabel, inRange: termsRange) {
            delegate?.didTapTextLink()
        }

    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {

            static let textFieldHeight: CGFloat = 40
            static let TopConstant: CGFloat = 60
            static let LeadingConstant: CGFloat = 30
            static let BottomButtonConstant: CGFloat = 118
            static let ButtonHeight: CGFloat = 46
            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10

        }

        struct Text {
            static let checkEgTextButton = "Check Egibility"
            static let newAccountTextButton = "New Account"
            static let titleLabelEgibilityText = "Check egibility or create new account"
            // TODO: Add this string to localizable.
            // swiftlint:disable:next line_length
            static let egibilityCheckText: String = "ACP requires proof of your identity to check if you are eligible for any of the assistance programs approved by FCC. If you are already receiving government benefits, check your eligiblity status by clicking the button below. Otherwise create a new account and follow the required steps in order to verify your identitiy.*"
            // swiftlint:disable:next line_length
            static let personalNoteInfoText = "*All of your personal and identity information goes through National Verifier (NV), a body of FCC. No information is stored by us or third-party services."
            static let Terms: String = "assistance programs"

        }
    }
}
