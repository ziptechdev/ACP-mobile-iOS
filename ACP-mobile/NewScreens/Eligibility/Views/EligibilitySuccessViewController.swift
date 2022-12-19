//
//  EligibilitySuccessViewController.swift
//  ACP-mobile
//
//  Created by Adi on 04/10/2022.
//

import UIKit
import SnapKit

class EligibilitySuccessViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: EligibilitySuccessViewModel

    // MARK: - Views

    private let successCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .successGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.CircleSize / 2
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
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(
            key: "verify_success_subtitle",
            isCenter: true
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        return label
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "verify_success_register")
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()

    private lazy var cancelTextButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "verify_success_cancel", textColor: .coreBlue)
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization

    init(viewModel: EligibilitySuccessViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        titleLabel.text = .formatLocalizedString(
            key: "verify_success_title",
            values: viewModel.firstName
        )
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
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.SuccessCircleOffsetY)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constants.CircleSize)
        }

        successImage.snp.makeConstraints { make in
            make.center.equalTo(successCircle.snp.center)
            make.width.height.equalTo(Constants.IconSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(successCircle.snp.bottom).offset(Constants.TitleOffsetVertical)
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.SubtitleOffsetY)
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
        }

        registerButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.ButtonOffsetVertical)
        }

        cancelTextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(registerButton.snp.bottom).offset(Constants.ButtonSpacingVertical)
        }

        cancelButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.CancelInsetHorizontal)
            make.height.width.equalTo(Constants.CancelButtonSize)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.CancelInsetVertical)
        }
    }

    // MARK: - Navigation

    @objc override func didTapRightButton() {
        viewModel.dismiss()
    }

    @objc func didTapCancel() {
        viewModel.dismiss()
    }

    @objc func didTapRegisterButton() {
        viewModel.goToRegistration()
    }

    // MARK: - Constants

    private struct Constants {
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
