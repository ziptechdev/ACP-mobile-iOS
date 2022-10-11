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
        textAlignment = .center

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        addGestureRecognizer(tap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    private func attributedInfoText() -> NSMutableAttributedString {
        let info = Constants.Text.Info as NSString
        let fullRange = NSRange(location: 0, length: info.length)
        let termsRange = info.range(of: Constants.Text.Terms)
        let privacyRange = info.range(of: Constants.Text.Privacy)

        let string = NSMutableAttributedString(string: Constants.Text.Info)
        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular), range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.gray06Dark, range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: termsRange)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: privacyRange)

        return string
    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let info = Constants.Text.Info as NSString
        let termsRange = info.range(of: Constants.Text.Terms)
        let privacyRange = info.range(of: Constants.Text.Privacy)

        if sender.didTapAttributedTextInLabel(label: self, inRange: termsRange) {
            delegate?.didTapTerms()
        } else if sender.didTapAttributedTextInLabel(label: self, inRange: privacyRange) {
            delegate?.didTapPrivacy()
        }
    }

    private struct Constants {
        struct Text {
            static let Info = "Read our Terms of Use and Privacy Policy."
            static let Privacy = "Privacy Policy"
            static let Terms = "Terms of Use"
        }
    }
}
