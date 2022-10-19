//
//  ACPRegistrationCompleteViewController.swift
//  ACP-mobile
//
//  Created by Adi on 19/10/2022.
//

import UIKit
import SnapKit

class ACPRegistrationCompleteViewController: UIViewController {

    // MARK: - Views

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "success")?.withRenderingMode(.alwaysTemplate)
        view.image = image
        view.tintColor = .white
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "registration_complete_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "registration_complete_subtitle")
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(attributedButtonTitle(), for: .normal)
        button.setAttributedTitle(attributedButtonTitle(), for: .highlighted)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = ""
        navigationController?.navigationBar.isHidden = false

        setupRightNavigationBarButton(color: .white)
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .coreBlue

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginButton)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.ImageInsetY)
            make.height.width.equalTo(Constants.Constraints.ImageSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(imageView.snp.bottom).offset(Constants.Constraints.TitleOffset)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffset)
        }

        loginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.ButtonInsetVertical)
        }
    }

    private func attributedButtonTitle() -> NSMutableAttributedString {
        let title: NSMutableAttributedString = .localizedString(key: "registration_complete_btn")
        let fullRange = NSRange(location: 0, length: title.length)

        title.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold), range: fullRange)
        title.addAttribute(.foregroundColor, value: UIColor.white, range: fullRange)
        title.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: fullRange)
        title.addAttribute(.underlineColor, value: UIColor.white, range: fullRange)

        return title
    }

    // MARK: - Callbacks

    @objc func didTapLoginButton() {
        let targetVC = ACPHomeScreenViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ImageInsetY: CGFloat = 128
            static let ImageSize: CGFloat = 128

            static let TitleOffset: CGFloat = 60
            static let ContentInset: CGFloat = 35

            static let SubtitleOffset: CGFloat = 20

            static let ButtonHeight: CGFloat = 46
            static let ButtonInsetVertical: CGFloat = 70
            static let ButtonCornerRadius: CGFloat = 10
        }
    }
}
