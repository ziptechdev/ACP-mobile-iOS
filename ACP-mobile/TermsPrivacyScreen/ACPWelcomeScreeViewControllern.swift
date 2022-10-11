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
        lbl.text = "Affordable Conectivity Program"
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
        view.addSubview(descriptionText)
        view.addSubview(continueButton)
        setupConstraints()
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
    @objc func didTaped(_ sender: UIButton!) {
        let vc = ACPTermsPrivacyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
