//
//  LandingViewController.swift
//  ACP-mobile
//
//  Created by Adi on 29/09/2022.
//

import UIKit
import SnapKit

class LandingViewController: UIViewController {

    // MARK: - Properties

    private var viewModel: WelcomeViewModel

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
        label.text = .localizedString(key: "landing_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(
            key: "landing_subtitle",
            color: .white,
            isCenter: true
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let getStartedButton: ACPImageButton = {
        let button = ACPImageButton(
            titleKey: "landing_btn",
            spacing: Constants.ButtonContentSpacing,
            cornerRadius: Constants.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initialization

    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        viewModel.dismiss()
    }

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
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.bottom.equalToSuperview().inset(Constants.ContentInsetVertical)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.bottom.equalTo(getStartedButton.snp.top).offset(-Constants.SubtitleBotOffset)
        }

        welcomeLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-Constants.TitleBotOffset)
        }
    }

    // MARK: - Navigation

    @objc func navigateToWelcome() {
        viewModel.goToWelcomePageOne()
    }

    // MARK: - Constants

    private struct Constants {
        static let ContentInsetVertical: CGFloat = 95
        static let ContentInsetHorizontal: CGFloat = 35

        static let ButtonHeight: CGFloat = 46
        static let ButtonContentSpacing: CGFloat = 10
        static let ButtonCornerRadius: CGFloat = 10

        static let SubtitleBotOffset: CGFloat = 120

        static let TitleBotOffset: CGFloat = 10
    }
}
