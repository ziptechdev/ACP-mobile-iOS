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
        img.image = UIImage(named: "acpSecondTabLeftLine")
        img.contentMode = .scaleAspectFit
        return img
    }()

    private lazy var rightTopLine: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "acpSecondTabRightLine")
        img.contentMode = .scaleAspectFit
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
            make.bottom.equalTo(scrollView)
        }

    }

    func setupViews() {
        contentView.addSubview(termsText)
        termsText.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        termsText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 25).isActive = true
        termsText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true

        contentView.addSubview(termsDescriptionText)
        termsDescriptionText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        termsDescriptionText.topAnchor.constraint(equalTo: termsText.topAnchor, constant: 10).isActive = true
        termsDescriptionText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true

        contentView.addSubview(privacyText)
        privacyText.topAnchor.constraint(equalTo: termsDescriptionText.bottomAnchor, constant: 10).isActive = true
        privacyText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 25).isActive = true
        privacyText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true

        contentView.addSubview(privacyDescriptionText)
        privacyDescriptionText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        privacyDescriptionText.topAnchor.constraint(equalTo: privacyText.bottomAnchor, constant: 10).isActive = true
        privacyDescriptionText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        privacyDescriptionText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        contentView.addSubview(acceptButton)
        acceptButton.topAnchor.constraint(equalTo: privacyDescriptionText.bottomAnchor, constant: 20).isActive = true
        acceptButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        acceptButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        acceptButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }

    // MARK: Functions
    @objc func didTaped(_ sender: UIButton!) {
        let vc = ACPHomeScreenViewController()
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
    }
}
