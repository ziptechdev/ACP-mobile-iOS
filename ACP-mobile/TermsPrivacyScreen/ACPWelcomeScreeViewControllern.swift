//
//  ACPWelcomeScreeViewController.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 7. 10. 2022..
//

import UIKit
import SnapKit

class ACPWelcomeScreeViewController: UIViewController {

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
        lbl.text = Constants.Text.ACPTitleText
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var descriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "\(NSLocalizedString("welcomeScreen_text", comment: ""))"
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .justified
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()

    private lazy var continueButton: UIButton! = {
      let button = UIButton()
      button.translatesAutoresizingMaskIntoConstraints = false
      button.backgroundColor = .white
      button.setTitleColor(.coreBlue, for: .normal)
      button.addTarget(self, action: #selector(didTaped(_:)), for: .touchUpInside)
        button.setTitle(Constants.Text.ContinueButton, for: .normal)
      button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
      return button
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .coreBlue
        view.addSubview(leftTopLine)
        view.addSubview(rightTopLine)
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        view.addSubview(continueButton)
        setupConstraints()
    }

    // MARK: - UI
    private func setupConstraints() {
        leftTopLine.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constants.Constraints.mainLROffset)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.imageTopOffset)
            make.width.equalTo(rightTopLine)
        }

        rightTopLine.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.Constraints.mainLROffset)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.imageTopOffset)
            make.width.equalTo(leftTopLine)
        }

        titleText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.mainLROffset)
            make.top.equalTo(rightTopLine.snp.bottom).offset(Constants.Constraints.titleTopOffset)
        }

        descriptionText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.mainLROffset)
            make.top.equalTo(titleText.snp.bottom).offset(Constants.Constraints.descriptionOffsetTop)
        }

        continueButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.Constraints.mainLROffset)
            make.top.equalTo(descriptionText.snp.bottom).offset(Constants.Constraints.ButtonOffsetTop)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }
    }

    // MARK: Functions
    @objc func didTaped(_ sender: UIButton!) {
//        btn to show ACPTermsPrivacyViewController
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let mainLROffset = 35
            static let imageTopOffset = 55

            static let titleTopOffset = 35

            static let descriptionOffsetTop = 10

            static let ButtonOffsetTop: CGFloat = 20
            static let ButtonHeight: CGFloat = 46
            static let ButtonCornerRadius: CGFloat = 10
        }

        struct Text {
            static let ACPTitleText = "Affordable Conectivity Program"
            static let ContinueButton = "Continue"
        }
    }

}
