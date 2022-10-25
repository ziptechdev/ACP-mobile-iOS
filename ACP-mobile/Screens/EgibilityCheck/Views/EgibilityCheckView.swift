//
//  EgibilityCheckView.swift
//  ACP-mobile
//
//  Created by Abi  on 1. 10. 2022..
//

import UIKit
import SnapKit

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
        button.setTitle(titleKey: "eligibility_btn")
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        return button
    }()

    let createNewAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle(titleKey: "new_account_btn", textColor: .coreBlue)
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
        titleLabel.text = .localizedString(key: "eligibility_title")
        descriptionLabel.attributedText = attributedInfoText()
        infoLabel.text = .localizedString(key: "eligibility_info")
    }

    private func attributedInfoText() -> NSMutableAttributedString {
        let string: NSMutableAttributedString = .localizedString(key: "eligibility_subtitle")
        let highlightRange = string.range(of: .localizedString(key: "eligibility_details_highlight"))

        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular))
        string.addAttribute(.foregroundColor, value: UIColor.gray01Light)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: highlightRange)

        return string
    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let string: String = .localizedString(key: "eligibility_subtitle")
        let termsRange = string.range(of: .localizedString(key: "eligibility_details_highlight"))

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
    }
}
