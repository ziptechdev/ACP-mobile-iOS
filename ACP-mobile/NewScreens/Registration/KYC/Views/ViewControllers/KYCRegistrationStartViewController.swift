//
//  KYCRegistrationStartViewController.swift
//  ACP-mobile
//
//  Created by Adi on 25/12/2022.
//

import UIKit
import SnapKit

class KYCRegistrationStartViewController: UIViewController {

    // MARK: - Properties

    private var viewModel: KYCRegistrationStartViewModel

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "not_verified_register_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(key: "not_verified_register_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var explanationLabel: UILabel = {
        let label = UILabel()
        label.attributedText = explanationAttributedText()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        label.addGestureRecognizer(tap)
        return label
    }()

    private let registerImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "new_account")
        return view
    }()

    private lazy var getStartedButton: ImageButton = {
        let button = ImageButton(
            titleKey: "not_verified_register_btn",
            spacing: Constants.ButtonContentSpacing,
            cornerRadius: Constants.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private let infoLabel = TermsAndPrivacyLabel()

    // MARK: - Initialization

    init(viewModel: KYCRegistrationStartViewModel) {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        infoLabel.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = false

        setupLeftNavigationBarButton()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(explanationLabel)
        view.addSubview(registerImageView)
        view.addSubview(getStartedButton)
        view.addSubview(infoLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.ContentInsetVertical)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.SubtitleOffsetVertical)
        }

        explanationLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.ExplanationOffsetVertical)
        }

        registerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(explanationLabel.snp.bottom).offset(Constants.ImageOffsetVertical)
            make.width.height.equalTo(Constants.ImageSize)
        }

        getStartedButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.bottom.equalTo(infoLabel.snp.top).offset(-Constants.ButtonOffsetVertical)
        }

        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.InfoLabelInsetY)
        }
    }

    private func explanationAttributedText() -> NSAttributedString {
        let string: NSMutableAttributedString = .localizedString(key: "not_verified_register_details")
        let highlightRange = string.range(of: .localizedString(key: "not_verified_register_highlight"))

        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular))
        string.addAttribute(.foregroundColor, value: UIColor.gray01Light)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: highlightRange)

        return string
    }

    // MARK: - Callbacks

    @objc func didTapButton() {
        viewModel.goToPersonalDetails()
    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let string: String = .localizedString(key: "not_verified_register_details")
        let highlightRange = string.range(of: .localizedString(key: "not_verified_register_highlight"))

        if sender.didTapAttributedTextInLabel(label: explanationLabel, inRange: highlightRange) {
            viewModel.openPartners()
        }
    }

    // MARK: - Constants

    private struct Constants {
        static let ContentInsetVertical: CGFloat = 96
        static let ContentInsetHorizontal: CGFloat = 35

        static let ImageSize: CGFloat = 128
        static let ImageOffsetVertical: CGFloat = 85

        static let SubtitleOffsetVertical: CGFloat = 20

        static let ExplanationOffsetVertical: CGFloat = 20

        static let EmailOffsetVertical: CGFloat = 30
        static let TextFieldOffsetVertical: CGFloat = 10

        static let ButtonHeight: CGFloat = 46
        static let ButtonContentSpacing: CGFloat = 10
        static let ButtonCornerRadius: CGFloat = 10
        static let ButtonOffsetVertical: CGFloat = 30

        static let InfoLabelInsetY: CGFloat = 60
    }
}

// MARK: - TermsAndPrivacyLabelDelegate

extension KYCRegistrationStartViewController: TermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        viewModel.openTerms()
    }

    func didTapPrivacy() {
        viewModel.openPrivacyPolicy()
    }
}
