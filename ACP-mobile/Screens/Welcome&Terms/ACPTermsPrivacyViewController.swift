//
//  ACPTermsPrivacyViewController.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 7. 10. 2022..
//

import UIKit
import SnapKit

class ACPTermsPrivacyViewController: UIViewController {

    // MARK: - Views

    private lazy var leftTopLine: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "tab_line")?.withRenderingMode(.alwaysTemplate)
        img.contentMode = .scaleAspectFit
        img.tintColor = .gray06Light
        return img
    }()

    private lazy var rightTopLine: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "tab_line")?.withRenderingMode(.alwaysTemplate)
        img.contentMode = .scaleAspectFit
        img.tintColor = .coreBlue
        return img
    }()

    private lazy var termsText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "privacy_title")
        lbl.numberOfLines = 0
        lbl.textColor = .coreBlue
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        return lbl
    }()

    private lazy var termsDescriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "terms_text")
        lbl.numberOfLines = 0
        lbl.textColor = .gray01Light
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        return lbl
    }()

    private lazy var consentText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "terms_consent")
        lbl.numberOfLines = 0
        lbl.textColor = .coreBlue
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        return lbl
    }()

    private lazy var consentTextDescirption: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "consenttext_description")
        lbl.numberOfLines = 0
        lbl.textAlignment = .justified
        lbl.textColor = .gray01Light
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        return lbl
    }()

    private lazy var informationCollectText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "terms_information")
        lbl.numberOfLines = 0
        lbl.textColor = .coreBlue
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        return lbl
    }()

    private lazy var inforCollectTextDesc: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "informationCollectTextDescription_description")
        lbl.numberOfLines = 0
        lbl.textColor = .gray01Light
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        return lbl
    }()

    private lazy var acceptButton: ACPShadowButton = {
        let button = ACPShadowButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .coreBlue
        button.setTitle(titleKey: "termsPrivacy_btn")
        button.addTarget(self, action: #selector(didTapAccept), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    let scrollView = UIScrollView()
    let contentView = UIView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(leftTopLine)
        view.addSubview(rightTopLine)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupConstraints()
        setupScrollView()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = .localizedString(key: "welcome_page_title")
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .regular),
            .foregroundColor: UIColor.gray06Dark
        ]

        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
    }

    // MARK: - UI

    private func setupConstraints() {
        leftTopLine.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constants.LeftTopLineLeftOffest)
            make.top.equalToSuperview().offset(Constants.LeftTopLineTopOffest)
            make.width.equalTo(rightTopLine)
        }

        rightTopLine.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.RightTopLineRightOffest)
            make.top.equalToSuperview().offset(Constants.RightTopLineTopOffest)
            make.width.equalTo(leftTopLine)
        }
    }

    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(leftTopLine).inset(Constants.ScrollViewTopInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView).inset(Constants.ContentViewBottomInset)
        }
    }

    func setupViews() {
        contentView.addSubview(termsText)
        termsText.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.right.left.equalToSuperview().inset(Constants.TermsTextLeftRightOffest)
        }

        contentView.addSubview(termsDescriptionText)
        termsDescriptionText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.TermsDescriptionLeftRightOffest)
            make.top.equalTo(termsText.snp.bottom).offset(Constants.TermsDescriptionTopOffest)
        }

        contentView.addSubview(consentText)
        consentText.snp.makeConstraints { make in
            make.top.equalTo(termsDescriptionText.snp.bottom).inset(Constants.PrivacyTextTopOffest)
            make.right.left.equalToSuperview().inset(Constants.PrivacyTextLeftRight)
        }

        contentView.addSubview(consentTextDescirption)
        consentTextDescirption.snp.makeConstraints { make in
            make.right.left.equalTo(contentView).inset(Constants.DescriptionLeftRight)
            make.top.equalTo(consentText.snp.bottom).inset(Constants.DescriptionTopOffest)
        }

        contentView.addSubview(informationCollectText)
        informationCollectText.snp.makeConstraints { make in
            make.right.left.equalTo(contentView).inset(Constants.DescriptionLeftRight)
            make.top.equalTo(consentTextDescirption.snp.bottom).inset(Constants.DescriptionTopOffest)
        }

        contentView.addSubview(inforCollectTextDesc)
        inforCollectTextDesc.snp.makeConstraints { make in
            make.right.left.equalTo(contentView).inset(Constants.DescriptionLeftRight)
            make.top.equalTo(informationCollectText.snp.bottom).inset(Constants.DescriptionTopOffest)
        }

        contentView.addSubview(acceptButton)
        acceptButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.ButtonLeftRightOffest)
            make.top.equalTo(inforCollectTextDesc.snp.bottom).offset(Constants.ButtonTopOffest)
            make.height.equalTo(Constants.ButtonHeight)
            make.bottom.equalToSuperview()
        }
    }

    // MARK: Functions

    @objc func didTapAccept() {
        let targetVC = EligibilityCheckViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }

    // MARK: Constants

    private struct Constants {
        static let LeftTopLineLeftOffest: CGFloat = 35
        static let LeftTopLineTopOffest: CGFloat = 120

        static let RightTopLineRightOffest: CGFloat = 35
        static let RightTopLineTopOffest: CGFloat = 120

        static let ScrollViewTopOffest: CGFloat = 20

        static let ContentViewBottomView: CGFloat = 75

        static let TermsTextLeftRightOffest: CGFloat = 35

        static let TermsDescriptionLeftRightOffest: CGFloat = 35
        static let TermsDescriptionTopOffest: CGFloat = 10

        static let PrivacyTextTopOffest: CGFloat = -10
        static let PrivacyTextLeftRight: CGFloat = 35

        static let DescriptionTopOffest: CGFloat = -10
        static let DescriptionLeftRight: CGFloat = 35

        static let ButtonLeftRightOffest: CGFloat = 35
        static let ButtonTopOffest: CGFloat = 20
        static let ButtonHeight: CGFloat = 46

        static let ContentViewBottomInset: CGFloat = 75
        static let ScrollViewTopInset: CGFloat = 20
    }
}
