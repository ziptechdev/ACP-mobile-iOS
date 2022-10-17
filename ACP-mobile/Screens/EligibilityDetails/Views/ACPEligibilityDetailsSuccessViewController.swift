//
//  ACPEligibilityDetailsSuccessViewController.swift
//  ACP-mobile
//
//  Created by Adi on 04/10/2022.
//

import UIKit
import SnapKit

class ACPEligibilityDetailsSuccessViewController: UIViewController {

    // MARK: - Views

    private let successCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .successGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.Constraints.CircleSize / 2
        view.layer.masksToBounds = true
        return view
    }()

    private let successImage: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "checkmark")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        view.image = image
        return view
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "x_mark")?.withRenderingMode(.alwaysTemplate)
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .gray01Dark
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "verify_success_title")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "verify_success_details")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray01Light
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        return label
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.localizedString(key: "verify_success_register"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()

    private lazy var cancelTextButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.localizedString(key: "verify_success_cancel"), for: .normal)
        button.setTitleColor(.coreBlue, for: .normal)
        button.setTitleColor(.coreBlue, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(successCircle)
        view.addSubview(successImage)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(registerButton)
        view.addSubview(cancelTextButton)
        view.addSubview(cancelButton)
    }

    private func setupConstraints() {
        successCircle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.SuccessCircleOffsetY)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constants.Constraints.CircleSize)
        }

        successImage.snp.makeConstraints { make in
            make.center.equalTo(successCircle.snp.center)
            make.width.height.equalTo(Constants.Constraints.IconSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(successCircle.snp.bottom).offset(Constants.Constraints.TitleOffsetVertical)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffsetY)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
        }

        registerButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }

        cancelTextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(registerButton.snp.bottom).offset(Constants.Constraints.ButtonSpacingVertical)
        }

        cancelButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.Constraints.CancelInsetHorizontal)
            make.height.width.equalTo(Constants.Constraints.CancelButtonSize)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.Constraints.CancelInsetVertical)
        }
    }

    // MARK: - Callbacks

    @objc func didTapCancel() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func didTapRegisterButton() {
        let viewController = ACPVerifiedRegistrationViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let SuccessCircleOffsetY: CGFloat = 175
            static let CircleSize: CGFloat = 120
            static let IconSize: CGFloat = 36

            static let TitleOffsetVertical: CGFloat = 30

            static let ContentInsetHorizontal: CGFloat = 35
            static let SubtitleOffsetY: CGFloat = 10

            static let ButtonHeight: CGFloat = 46
            static let ButtonOffsetVertical: CGFloat = 60
            static let ButtonSpacingVertical: CGFloat = 15
            static let ButtonCornerRadius: CGFloat = 10

            static let CancelInsetVertical: CGFloat = 38
            static let CancelInsetHorizontal: CGFloat = 35
            static let CancelButtonSize: CGFloat = 14
        }
    }
}
