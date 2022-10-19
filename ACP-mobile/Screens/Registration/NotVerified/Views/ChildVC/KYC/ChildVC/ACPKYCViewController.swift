//
//  ACPKYCViewController.swift
//  ACP-mobile
//
//  Created by Adi on 18/10/2022.
//

import UIKit
import SnapKit

class ACPKYCViewController: UIViewController {

	// MARK: - Properties

    weak var delegate: ACPTabMenuDelegate?

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "kyc_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedSubitleText()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        label.addGestureRecognizer(tap)
        return label
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.localizedString(key: "kyc_btn"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(startButton)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalToSuperview().inset(Constants.Constraints.TitleInsetY)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffset)
        }

        startButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }
    }

    private func attributedSubitleText() -> NSMutableAttributedString {
        let subtitle: NSString = .localizedString(key: "kyc_subtitle")
        let fullRange = NSRange(location: 0, length: subtitle.length)
        let highlightRange = subtitle.range(of: .localizedString(key: "kyc_highlight"))

        let string: NSMutableAttributedString = .localizedString(key: "kyc_subtitle")
        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular), range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.gray01Light, range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: highlightRange)

        return string
    }

    // MARK: - Callbacks

    @objc func didTapStartButton() {
        delegate?.didTapNextButton()
    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let subtitle: NSString = .localizedString(key: "kyc_subtitle")
        let highlightRange = subtitle.range(of: .localizedString(key: "kyc_highlight"))

        if sender.didTapAttributedTextInLabel(label: subtitleLabel, inRange: highlightRange) {
            // TODO: Add Link
            print("kyc_highlight")
        }
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let TitleInsetY: CGFloat = 60
            static let ContentInset: CGFloat = 35

            static let SubtitleOffset: CGFloat = 30

            static let ButtonHeight: CGFloat = 46
            static let ButtonOffsetVertical: CGFloat = 60
            static let ButtonCornerRadius: CGFloat = 10
        }
    }
}
