//
//  ACPLandingViewController.swift
//  ACP-mobile
//
//  Created by Adi on 29/09/2022.
//

import UIKit
import SnapKit

class ACPLandingScreenViewController: UIViewController {

    // MARK: - Views

    private let welcomeImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "welcome")
        return view
    }()

    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        return view
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.Welcome
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.Details
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let getStartedButton: ACPImageButton = {
        let button = ACPImageButton(
            spacing: Constants.Constraints.ButtonContentSpacing,
            cornerRadius: Constants.Constraints.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Text.GetStarted, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        setupUI()

        getStartedButton.addTarget(self, action: #selector(navigateToWelcome), for: .touchUpInside)
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(welcomeImageView)
        view.addSubview(overlayView)
        view.addSubview(welcomeLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(getStartedButton)
    }

    private func setupConstraints() {
        welcomeImageView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }

        overlayView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }

        getStartedButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.bottom.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.bottom.equalTo(getStartedButton.snp.top).offset(-Constants.Constraints.SubtitleBotOffset)
        }

        welcomeLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-Constants.Constraints.TitleBotOffset)
        }
    }

    // MARK: - Navigation

    @objc func navigateToWelcome() {
        let targetVC = ACPWelcomeScreenViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ContentInsetVertical: CGFloat = 95
            static let ContentInsetHorizontal: CGFloat = 35

            static let ButtonHeight: CGFloat = 46
            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10

            static let SubtitleBotOffset: CGFloat = 120

            static let TitleBotOffset: CGFloat = 10
        }

        struct Text {
            static let Welcome = "Welcome to ACP Mobile"
            static let Details = """
                This is your first time exploring ACP Mobile app.
                Press ‘Get Started’ button to explore the benfits.
                """
            static let GetStarted = "Get Started"
        }
    }
}
