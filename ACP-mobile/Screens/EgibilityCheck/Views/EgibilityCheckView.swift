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
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.shadowColor = UIColor.gray03Light.cgColor
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
        checkEgibilityButton.setTitle(.localizedString(key: "eligibility_btn"), for: .normal)
        createNewAccountButton.setTitle(.localizedString(key: "new_account_btn"), for: .normal)
    }

    private func attributedInfoText() -> NSMutableAttributedString {
        let info: NSString = .localizedString(key: "eligibility_subtitle")
        let fullRange = NSRange(location: 0, length: info.length)
        let termsRange = info.range(of: .localizedString(key: "eligibility_details_highlight"))

        let string: NSMutableAttributedString = .localizedString(key: "eligibility_subtitle")
        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular), range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.gray01Light, range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: termsRange)

        return string
    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let info: NSString = .localizedString(key: "eligibility_subtitle")
        let termsRange = info.range(of: .localizedString(key: "eligibility_details_highlight"))

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
