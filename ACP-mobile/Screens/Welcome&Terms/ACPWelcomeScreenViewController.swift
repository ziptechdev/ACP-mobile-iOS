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
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    // TODO: Separate into multiple labels for easier layout
    private lazy var descriptionText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "welcome_text")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .justified
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        return lbl
    }()

    private lazy var continueButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        button.setTitle(titleKey: "welcome_btn", textColor: .coreBlue)
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
        view.addSubview(descriptionText)
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
            make.left.equalToSuperview().inset(35)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(55)
            make.width.equalTo(rightTopLine)
        }

        rightTopLine.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(35)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(55)
            make.width.equalTo(leftTopLine)
        }

        titleText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(35)
            make.top.equalTo(rightTopLine.snp.bottom).offset(35)
        }

        descriptionText.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(35)
            make.top.equalTo(titleText.snp.bottom).offset(10)
        }

        continueButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(35)
            make.top.equalTo(descriptionText.snp.bottom).offset(20)
            make.height.equalTo(46)
        }
    }

    // MARK: Functions

    @objc func didTapContinue() {
        let targetVC = ACPTermsPrivacyViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }

    // TODO: Add Constants
}
