//
//  EligibilityCheckViewController.swift
//  ACP-mobile
//
//  Created by Abi  on 1. 10. 2022.
//

import UIKit
import SnapKit

class EligibilityCheckViewController: UIViewController {

    // MARK: - Properties

    private var viewModel: WelcomeViewModel

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coreBlue
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var textStackView = UIStackView(
        subviews: [
            titleLabel,
            descriptionLabel
        ],
        spacing: 15
    )

    let checkEligibilityButton: UIButton = {
        let button = UIButton()
        button.setTitle(titleKey: "eligibility_btn")
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        return button
    }()

    let createNewAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle(titleKey: "new_account_btn", textColor: .coreBlue)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        button.layer.borderColor = UIColor.coreBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var buttonAndInfoStackView = UIStackView(
        subviews: [
            checkEligibilityButton,
            createNewAccountButton,
            infoLabel
        ],
        spacing: 30
    )

    private let termsLabel = ACPTermsAndPrivacyLabel()

    // MARK: - Initialization

    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = .localizedString(key: "eligibility_page_title")
        navigationController?.navigationBar.isHidden = false

        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        termsLabel.delegate = self
    }
    // MARK: - UI

    func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setUpConstraints()
        setText()

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        descriptionLabel.addGestureRecognizer(tap)

        checkEligibilityButton.addTarget(self, action: #selector(checkEligibilityTapped), for: .touchUpInside)
        createNewAccountButton.addTarget(self, action: #selector(createNewAccountTapped), for: .touchUpInside)
    }

    private func addSubviews() {
        view.addSubview(textStackView)
        view.addSubview(buttonAndInfoStackView)
        view.addSubview(termsLabel)
    }

    private func setUpConstraints() {
        textStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.TopConstant)
            make.left.right.equalToSuperview().inset(Constants.InsetHorizontal)
        }

        buttonAndInfoStackView.snp.makeConstraints { make in
            make.bottom.equalTo(termsLabel.snp.top).inset(-Constants.BottomButtonConstant)
            make.left.right.equalToSuperview().inset(Constants.InsetHorizontal)
        }

        termsLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.InsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(-Constants.InsetVertical)
        }

        createNewAccountButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.ButtonHeight)
        }

        checkEligibilityButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.ButtonHeight)
        }
    }

    private func setText() {
        titleLabel.text = .localizedString(key: "eligibility_title")
        descriptionLabel.attributedText = attributedInfoText()
        infoLabel.attributedText = NSMutableAttributedString.subtitleString(key: "eligibility_info")
    }

    private func attributedInfoText() -> NSMutableAttributedString {
        let string: NSMutableAttributedString = .subtitleString(key: "eligibility_subtitle")

        let highlightRange = string.range(of: .localizedString(key: "eligibility_details_highlight_text"))
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: highlightRange)

        return string
    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let info: String = .localizedString(key: "eligibility_subtitle")
        let termsRange = info.range(of: .localizedString(key: "eligibility_details_highlight_text"))

        if sender.didTapAttributedTextInLabel(label: descriptionLabel, inRange: termsRange) {
            viewModel.openAssistanceLink()
        }
    }

    // MARK: - Navigation

    @objc func checkEligibilityTapped() {
        viewModel.goToEligibility()
    }

    @objc func createNewAccountTapped() {
        viewModel.goToKYC()
    }

    // MARK: - Constants

    private struct Constants {
        static let textFieldHeight: CGFloat = 40
        static let TopConstant: CGFloat = 60
        static let BottomButtonConstant: CGFloat = 118
        static let ButtonHeight: CGFloat = 46
        static let ButtonCornerRadius: CGFloat = 10
        static let InsetHorizontal: CGFloat = 35
        static let InsetVertical: CGFloat = 5
        static let HeaderCornerRadius: CGFloat = 10
        static let HeaderHeight: CGFloat = 40
    }
}

// MARK: - ACPTermsAndPrivacyLabelDelegate

extension EligibilityCheckViewController: ACPTermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        viewModel.openTerms()
    }

    func didTapPrivacy() {
        viewModel.openPrivacyPolicy()
    }
}
