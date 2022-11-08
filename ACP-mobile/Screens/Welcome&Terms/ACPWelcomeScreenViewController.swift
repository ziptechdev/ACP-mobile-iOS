//
//  ACPWelcomeScreenViewController.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 7. 10. 2022..
//

import UIKit
import SnapKit

class ACPWelcomeScreenViewController: UIViewController {

    // MARK: - Views

    private lazy var leftTopLine: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "tab_line")
        img.contentMode = .scaleAspectFit
        return img
    }()

    private lazy var rightTopLine: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "tab_line")
        img.alpha = 0.3
        img.contentMode = .scaleAspectFit
        return img
    }()

    private lazy var titleText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "welcome_title")
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var firstDescriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSMutableAttributedString.subtitleString(
            key: "welcome_first_descirption_text",
            color: .white
        )
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var secondDescriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSMutableAttributedString.subtitleString(
            key: "welcome_second_descirption_text",
            color: .white
        )
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var thirdDescriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSMutableAttributedString.subtitleString(
            key: "welcome_third_descirption_text",
            color: .white
        )
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        return lbl
    }()

    private lazy var termsPrivacyUrl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = attributedTextStyle()
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var continueButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        button.setTitle(titleKey: "welcome_btn", textColor: .coreBlue)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .coreBlue

        view.addSubview(leftTopLine)
        view.addSubview(rightTopLine)
        view.addSubview(titleText)
        view.addSubview(firstDescriptionText)
        view.addSubview(secondDescriptionText)
        view.addSubview(thirdDescriptionText)
        view.addSubview(termsPrivacyUrl)
        view.addSubview(continueButton)
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = .localizedString(key: "welcome_page_title")

        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .regular),
            .foregroundColor: UIColor.white
        ]

        setupRightNavigationBarButton(color: .white)
        setupLeftNavigationBarButton(color: .white)
    }

    // MARK: - UI

    private func setupConstraints() {
        leftTopLine.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.VerticalContentInset)
            make.width.equalTo(rightTopLine)
        }

        rightTopLine.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.VerticalContentInset)
            make.width.equalTo(leftTopLine)
        }

        titleText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(rightTopLine.snp.bottom).offset(Constants.TitleTextTopOffset)
        }

        firstDescriptionText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(titleText.snp.bottom).offset(Constants.DescirptionTopOffest)
        }

        secondDescriptionText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(firstDescriptionText.snp.bottom).offset(Constants.DescriptionTextTopOffset)
        }

        thirdDescriptionText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(secondDescriptionText.snp.bottom).offset(Constants.DescriptionTextTopOffset)
        }

        termsPrivacyUrl.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(thirdDescriptionText.snp.bottom).offset(Constants.DescriptionTextTopOffset)
        }

        continueButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(termsPrivacyUrl.snp.bottom).offset(Constants.ButtonTopOffest)
            make.height.equalTo(Constants.ButtonHeight)
        }
    }

    private func attributedTextStyle() -> NSAttributedString {
        let string: NSMutableAttributedString = .localizedString(key: "welcome_privacyTerms_descirption_text")
        let termsHighlighted = string.range(of: .localizedString(key: "welcome_privacyTerms_terms"))
        let privacyHighlighted = string.range(of: .localizedString(key: "welcome_privacyTerms_privacy"))

        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .bold))
        string.addAttribute(.paragraphStyle, value: NSMutableParagraphStyle.lineHeight)
        string.addAttribute(.foregroundColor, value: UIColor.white)
        string.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: termsHighlighted)
        string.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: privacyHighlighted)

        return string
    }

    // MARK: Functions

    @objc func didTapContinue() {
        let targetVC = ACPTermsPrivacyViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }

    // MARK: - Constants

    private struct Constants {
        static let HorizontalContentInset: CGFloat = 35
        static let VerticalContentInset: CGFloat = 25

        static let TitleTextTopOffset: CGFloat = 30

        static let DescirptionTopOffest: CGFloat = 10
        static let DescriptionTextTopOffset: CGFloat = 20

        static let ButtonTopOffest: CGFloat = 40
        static let ButtonCornerRadius: CGFloat = 10
        static let ButtonHeight: CGFloat = 46
    }
}
