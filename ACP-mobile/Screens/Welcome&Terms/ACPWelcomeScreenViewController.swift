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
        lbl.text = "Affordable Conectivity Program"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var firstDescriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("welcomeScreen_first_descirption_text", comment: "")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        return lbl
    }()

    private lazy var secondDescriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("welcomeScreen_second_descirption_text", comment: "")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        return lbl
    }()

    private lazy var thirdDescriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("welcomeScreen_third_descirption_text", comment: "")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        return lbl
    }()

    private lazy var termsPrivacyUrl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = NSLocalizedString("welcomeScreen_privacyTerms_descirption_text", comment: "")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        return lbl
    }()

    private lazy var continueButton: UIButton! = {
      let button = UIButton()
      button.translatesAutoresizingMaskIntoConstraints = false
      button.backgroundColor = .white
      button.setTitleColor(.coreBlue, for: .normal)
      button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
      button.setTitle("Continue", for: .normal)
      button.layer.masksToBounds = true
      button.layer.cornerRadius = 10
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
        title = "Welcome"
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
            make.left.equalToSuperview().inset(Constants.Constraints.LeftLineLeftOffest)
            make.top.equalToSuperview().inset(Constants.Constraints.LeftTopLineOffest)
            make.width.equalTo(rightTopLine)
        }

        rightTopLine.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.Constraints.RighLineLeftOffest)
            make.top.equalToSuperview().inset(Constants.Constraints.RightTopLineOffest)
            make.width.equalTo(leftTopLine)
        }

        titleText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.TitleLeftRighOffest)
            make.top.equalTo(rightTopLine.snp.bottom).offset(Constants.Constraints.TitleTextTopOffset)
        }

        firstDescriptionText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.DescriptionTextLeftRightOffest)
            make.top.equalTo(titleText.snp.bottom).offset(Constants.Constraints.DescirptionTopOffest)
        }

        secondDescriptionText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.DescriptionTextLeftRightOffest)
            make.top.equalTo(firstDescriptionText.snp.bottom).offset(Constants.Constraints.DescriptionTextTopOffset)
        }

        thirdDescriptionText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.DescriptionTextLeftRightOffest)
            make.top.equalTo(secondDescriptionText.snp.bottom).offset(Constants.Constraints.DescriptionTextTopOffset)
        }

        termsPrivacyUrl.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.DescriptionTextLeftRightOffest)
            make.top.equalTo(thirdDescriptionText.snp.bottom).offset(Constants.Constraints.DescriptionTextTopOffset)
        }

        continueButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.ButtonLeftRightOffest)
            make.top.equalTo(termsPrivacyUrl.snp.bottom).offset(Constants.Constraints.ButtonTopOffest)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }
    }

    // MARK: Functions
    @objc func didTapContinue() {
        let targetVC = ACPTermsPrivacyViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {

            static let LeftTopLineOffest: CGFloat = 140
            static let LeftLineLeftOffest: CGFloat = 35

            static let RightTopLineOffest: CGFloat = 140
            static let RighLineLeftOffest: CGFloat = 35

            static let TitleTextTopOffset: CGFloat = 35
            static let TitleLeftRighOffest: CGFloat = 35

            static let DescirptionTopOffest: CGFloat = 10
            static let DescriptionTextTopOffset: CGFloat = 20
            static let DescriptionTextLeftRightOffest: CGFloat = 35

            static let ButtonTopOffest: CGFloat = 40
            static let ButtonHeight: CGFloat = 46
            static let ButtonLeftRightOffest: CGFloat = 35

        }

        struct Text {
            static let Terms: String = "terms of use"
            static let Privacy: String = "privacy policy"
        }
    }
}
