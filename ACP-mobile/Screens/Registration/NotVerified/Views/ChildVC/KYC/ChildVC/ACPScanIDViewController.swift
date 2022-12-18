//
//  ACPScanIDViewController.swift
//  ACP-mobile
//
//  Created by Adi on 18/10/2022.
//

import UIKit
import SnapKit

class ACPScanIDViewController: UIViewController {

    // MARK: - Properties

    weak var delegate: ACPTabMenuDelegate?

    // MARK: - Views

    private let cardView = ACPBorderedView(imageName: "scan_id")

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "kyc_scan_id_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedSubitleText()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var scanFrontButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "kyc_scan_id_btn")
        button.addTarget(self, action: #selector(didTapScanFrontButton), for: .touchUpInside)
        return button
    }()

    private lazy var scanBackButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "kyc_scan_id_btn_2")
        button.addTarget(self, action: #selector(didTapScanBackButton), for: .touchUpInside)
        return button
    }()

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
        view.addSubview(cardView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(scanFrontButton)
        view.addSubview(scanBackButton)
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalToSuperview().inset(Constants.Constraints.CardInsetY)
            make.height.equalTo(Constants.Constraints.CardHeight)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(cardView.snp.bottom).offset(Constants.Constraints.TitleInsetY)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffset)
        }

        scanFrontButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }

        scanBackButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(scanFrontButton.snp.bottom).offset(Constants.Constraints.ButtonSpacingVertical)
        }
    }

    private func attributedSubitleText() -> NSMutableAttributedString {
        let string: NSMutableAttributedString = .subtitleString(
            key: "kyc_scan_id_subtitle",
            isCenter: true
        )
        let highlightRange = string.range(of: .localizedString(key: "kyc_scan_id_highlight"))

        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .semibold), range: highlightRange)

        return string
    }

    // MARK: - Callbacks

    @objc func didTapScanFrontButton() {
        delegate?.didTapNextButton()
    }

    @objc func didTapScanBackButton() {
        delegate?.didTapNextButton()
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let CardInsetY: CGFloat = 30
            static let CardHeight: CGFloat = 180

            static let TitleInsetY: CGFloat = 30
            static let ContentInset: CGFloat = 35

            static let SubtitleOffset: CGFloat = 20

            static let ButtonHeight: CGFloat = 46
            static let ButtonOffsetVertical: CGFloat = 30
            static let ButtonSpacingVertical: CGFloat = 20
            static let ButtonCornerRadius: CGFloat = 10
        }
    }
}
