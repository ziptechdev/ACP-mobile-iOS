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
        lbl.text = Constants.Text.TermsTitleText
        lbl.numberOfLines = 0
        lbl.textColor = .coreBlue
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        return lbl
    }()

    private lazy var termsDescriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("terms_text", comment: "")
        lbl.numberOfLines = 0
        lbl.textAlignment = .justified
        lbl.textColor = .gray06Dark
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()

    private lazy var privacyText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = Constants.Text.PrivacyTitleText
        lbl.numberOfLines = 0
        lbl.textColor = .coreBlue
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        return lbl
    }()

    private lazy var privacyDescriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "\(NSLocalizedString("privacy_text", comment: ""))"
        lbl.numberOfLines = 0
        lbl.textAlignment = .justified
        lbl.textColor = .gray06Dark
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()

    private lazy var acceptButton: UIButton! = {
      let button = UIButton()
      button.translatesAutoresizingMaskIntoConstraints = false
      button.backgroundColor = .coreBlue
      button.setTitleColor(.white, for: .normal)
      button.addTarget(self, action: #selector(didTaped(_:)), for: .touchUpInside)
        button.setTitle(Constants.Text.ContinueButton, for: .normal)
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

    // MARK: - UI
    private func setupConstraints() {
        leftTopLine.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constants.Constraints.MainLROffset)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.ImageTopOffset)
            make.width.equalTo(rightTopLine)
        }

        rightTopLine.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.Constraints.MainLROffset)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.ImageTopOffset)
            make.width.equalTo(leftTopLine)
        }

    }

    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(leftTopLine).inset(Constants.Constraints.ScrollTopOffset)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView).inset(Constants.Constraints.ContentViewBottomOffset)
        }

    }

    func setupViews() {
        contentView.addSubview(termsText)

        termsText.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.right.equalTo(contentView).inset(Constants.Constraints.TermsTextLROffset)
            make.left.equalTo(contentView).inset(Constants.Constraints.TermsTextLROffset)
        }

        contentView.addSubview(termsDescriptionText)

        termsDescriptionText.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(Constants.Constraints.TermsDescriptionRightOffset)
            make.top.equalTo(termsText).inset(Constants.Constraints.TermsDescriptionTopOffset)
            make.left.equalTo(contentView).inset(Constants.Constraints.TermsDescriptionLeftOffset)
        }

        contentView.addSubview(privacyText)

        privacyText.snp.makeConstraints { make in
            make.top.equalTo(termsDescriptionText.snp.bottom).inset(Constants.Constraints.PrivacyTextTopOffset)
            make.right.equalTo(contentView).inset(Constants.Constraints.PrivacyTextLROffset)
            make.left.equalTo(contentView).inset(Constants.Constraints.PrivacyTextLROffset)
        }

        contentView.addSubview(privacyDescriptionText)

        privacyDescriptionText.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(Constants.Constraints.PrivacyDescriptionRightOffset)
            make.top.equalTo(privacyText.snp.bottom).inset(Constants.Constraints.PrivacyTextTopOffset)
            make.left.equalTo(contentView).inset(Constants.Constraints.PrivacyDescirptionLeftOffset)
            make.bottom.equalTo(contentView)
        }

        contentView.addSubview(acceptButton)
        acceptButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.MainLROffset)
            make.top.equalTo(privacyDescriptionText.snp.bottom).offset(Constants.Constraints.ButtonOffsetTop)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }

    }

    // MARK: Functions
    @objc func didTaped(_ sender: UIButton!) {
//        btn to show ACP
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let MainLROffset = 35
            static let ImageTopOffset = 55

            static let ScrollTopOffset = 20
            static let ContentViewBottomOffset = 75

            static let TermsTextLROffset = 25

            static let TermsDescriptionRightOffset = 30
            static let TermsDescriptionTopOffset = 10
            static let TermsDescriptionLeftOffset = 25

            static let PrivacyTextLROffset = 25
            static let PrivacyTextTopOffset = -10

            static let PrivacyDescriptionRightOffset = 30
            static let PrivacyDescriptionTopOffset = -10
            static let PrivacyDescirptionLeftOffset = 25

            static let ButtonOffsetTop: CGFloat = 20
            static let ButtonHeight: CGFloat = 46
            static let ButtonCornerRadius: CGFloat = 10
        }

        struct Text {
            static let PrivacyTitleText = "Privacy Policy"
            static let TermsTitleText = "Terms of Use"
            static let ContinueButton = "Accept"
        }
    }
}
