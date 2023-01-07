//
//  EligibilityRegistrationSuccessViewController.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import UIKit
import SnapKit

class EligibilityRegistrationSuccessViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: EligibilityRegistrationSuccessViewModel

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
        label.attributedText = NSMutableAttributedString.subtitleString(
            key: "registration_complete_subtitle",
            color: .white,
            isCenter: true
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
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

    // MARK: - Initialization

    init(viewModel: EligibilityRegistrationSuccessViewModel) {
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
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.ImageInsetY)
            make.height.width.equalTo(Constants.ImageSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInset)
            make.top.equalTo(imageView.snp.bottom).offset(Constants.TitleOffset)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInset)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.SubtitleOffset)
        }

        loginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInset)
            make.height.equalTo(Constants.ButtonHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.ButtonInsetVertical)
        }
    }

    private func attributedButtonTitle() -> NSMutableAttributedString {
        let string: NSMutableAttributedString = .localizedString(key: "registration_complete_btn")

        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .semibold))
        string.addAttribute(.foregroundColor, value: UIColor.white)
        string.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue)
        string.addAttribute(.underlineColor, value: UIColor.white)

        return string
    }

    // MARK: - Coordination

    @objc func didTapLoginButton() {
        viewModel.goToLogin()
    }

    // MARK: - Constants

    private struct Constants {
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
