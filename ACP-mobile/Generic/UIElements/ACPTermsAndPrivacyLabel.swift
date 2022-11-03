//
//  ACPTermsAndPrivacyLabel.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit

// MARK: - ACPTermsAndPrivacyLabelDelegate

protocol ACPTermsAndPrivacyLabelDelegate: AnyObject {
    func didTapTerms()
    func didTapPrivacy()
}

class ACPTermsAndPrivacyLabel: UILabel {

    // MARK: - Properties

    weak var delegate: ACPTermsAndPrivacyLabelDelegate?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        attributedText = attributedInfoText()

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        addGestureRecognizer(tap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    private func attributedInfoText() -> NSMutableAttributedString {
        let string: NSMutableAttributedString = .localizedString(key: "info_label_text")
        let termsRange = string.range(of: .localizedString(key: "info_label_terms"))
        let privacyRange = string.range(of: .localizedString(key: "info_label_privacy"))

        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular))
        string.addAttribute(.paragraphStyle, value: NSMutableParagraphStyle.center)
        string.addAttribute(.foregroundColor, value: UIColor.gray06Dark)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: termsRange)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: privacyRange)

        return string
    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let string: String = .localizedString(key: "info_label_text")
        let termsRange = string.range(of: .localizedString(key: "info_label_terms"))
        let privacyRange = string.range(of: .localizedString(key: "info_label_privacy"))

        if sender.didTapAttributedTextInLabel(label: self, inRange: termsRange) {
            delegate?.didTapTerms()
        } else if sender.didTapAttributedTextInLabel(label: self, inRange: privacyRange) {
            delegate?.didTapPrivacy()
        }
    }
}
