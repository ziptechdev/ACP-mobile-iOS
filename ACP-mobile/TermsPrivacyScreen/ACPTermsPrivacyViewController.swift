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
        img.image = UIImage(named: "tab_line")
        img.contentMode = .scaleAspectFit
        img.tintColor = .gray
        return img
    }()

    private lazy var rightTopLine: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "tab_line")
        img.contentMode = .scaleAspectFit
        img.tintColor = .coreBlue
        return img
    }()

    private lazy var termsText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Terms of Use"
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
        lbl.textColor = .black
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()

    private lazy var privacyText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Privacy Policy"
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
        lbl.textColor = .black
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
      button.setTitle("Accept", for: .normal)
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
            make.left.equalToSuperview().inset(35)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(55)
            make.width.equalTo(rightTopLine)
        }

        rightTopLine.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(35)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(55)
            make.width.equalTo(leftTopLine)
        }

    }

    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(leftTopLine).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView).inset(75)
        }

    }

    func setupViews() {
        contentView.addSubview(termsText)

        termsText.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.right.equalTo(contentView).inset(25)
            make.left.equalTo(contentView).inset(25)
        }

        contentView.addSubview(termsDescriptionText)

        termsDescriptionText.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(30)
            make.top.equalTo(termsText).inset(10)
            make.left.equalTo(contentView).inset(25)
        }

        contentView.addSubview(privacyText)

        privacyText.snp.makeConstraints { make in
            make.top.equalTo(termsDescriptionText.snp.bottom).inset(-10)
            make.right.equalTo(contentView).inset(25)
            make.left.equalTo(contentView).inset(25)
        }

        contentView.addSubview(privacyDescriptionText)

        privacyDescriptionText.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(30)
            make.top.equalTo(privacyText.snp.bottom).inset(-10)
            make.left.equalTo(contentView).inset(25)
            make.bottom.equalTo(contentView)
        }

        contentView.addSubview(acceptButton)
        acceptButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(35)
            make.top.equalTo(privacyDescriptionText.snp.bottom).offset(20)
            make.height.equalTo(46)
        }

    }

    // MARK: Functions
    @objc func didTaped(_ sender: UIButton!) {
//        btn to show ACP
    }
}
