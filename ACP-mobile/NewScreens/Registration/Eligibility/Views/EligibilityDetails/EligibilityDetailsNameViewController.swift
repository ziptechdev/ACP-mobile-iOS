//
//  EligibilityDetailsNameViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

class EligibilityDetailsNameViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: EligibilityDetailsViewModel
    weak var delegate: TabMenuDelegate?

    private lazy var textFields: [TextInput] = [
        nameTextField, middleNameTextField, lastNameTextField
    ]

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "eligibility_details_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(key: "eligibility_details_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var nameTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "eligibility_details_name")
        view.textField.delegate = self
        return view
    }()

    private lazy var middleNameTextField: TextField = {
        let view = TextField()
        view.titleLabel.attributedText = attributedTitleText()
        view.textField.delegate = self
        return view
    }()

    private lazy var lastNameTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "eligibility_details_last_name")
        view.textField.delegate = self
        return view
    }()

    private let noBlankLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "eligibility_details_info")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray01Light
        return label
    }()

    private lazy var nextButton: ImageButton = {
        let button = ImageButton(
            titleKey: "eligibility_details_btn",
            spacing: Constants.ButtonContentSpacing,
            cornerRadius: Constants.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.isUserInteractionEnabled = false
        button.backgroundColor = .lavenderGray
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private lazy var titleStackView = UIStackView(
        subviews: [
            titleLabel,
            subtitleLabel
        ],
        spacing: Constants.titleStackViewSpacing
    )

    private lazy var fieldsStackView = UIStackView(
        subviews: [
            nameTextField,
            middleNameTextField,
            lastNameTextField,
            noBlankLabel
        ],
        spacing: Constants.fieldsStackViewSpacing
    )

    private lazy var topStackView = UIStackView(
        subviews: [
            titleStackView,
            fieldsStackView
        ],
        spacing: Constants.topStackViewSpacing
    )

    // MARK: - Initialization

    init(viewModel: EligibilityDetailsViewModel) {
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
        showValuesIfPresent()
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(topStackView)
        view.addSubview(nextButton)
    }

    private func setupConstraints() {
        topStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalToSuperview().inset(Constants.ContentInsetVertical)
        }

        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(topStackView.snp.bottom).offset(Constants.ButtonOffsetVertical)
        }
    }

    private func attributedTitleText() -> NSMutableAttributedString {
        let string: NSMutableAttributedString = .localizedString(key: "eligibility_details_middle_name")
        let highlightRange = string.range(of: .localizedString(key: "eligibility_details_highlight"))

        string.addAttribute(.foregroundColor, value: UIColor.gray06Dark)
        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular))
        string.addAttribute(.foregroundColor, value: UIColor.gray01Light, range: highlightRange)

        return string
    }

    // MARK: - Presenting

    private func showValuesIfPresent() {
        nameTextField.textField.text = viewModel.model.firstName
        middleNameTextField.textField.text = viewModel.model.middleName
        lastNameTextField.textField.text = viewModel.model.lastName

        checkValues()
    }

    private func checkValues() {
        let textFieldsToCheck = textFields.filter({ $0.textField != middleNameTextField.textField })
        let isEnabled = textFieldsToCheck.allSatisfy({ !$0.isEmpty })

        nextButton.isUserInteractionEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }

    // MARK: - Callback

    @objc func didTapButton() {
        viewModel.model.firstName = nameTextField.text
        viewModel.model.middleName = middleNameTextField.text
        viewModel.model.lastName = lastNameTextField.text

        delegate?.didTapNextButton()
    }

    // MARK: - Constants

    private struct Constants {
        static let ContentInsetVertical: CGFloat = 60
        static let ContentInsetHorizontal: CGFloat = 35

        static let titleStackViewSpacing: CGFloat = 10
        static let fieldsStackViewSpacing: CGFloat = 10
        static let topStackViewSpacing: CGFloat = 30

        static let ButtonHeight: CGFloat = 46
        static let ButtonContentSpacing: CGFloat = 10
        static let ButtonCornerRadius: CGFloat = 10
        static let ButtonOffsetVertical: CGFloat = 60
    }
}

// MARK: - UITextFieldDelegate

extension EligibilityDetailsNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentIndex = textFields.firstIndex(where: { $0.textField == textField }) else {
            return true
        }

        let nextIndex = currentIndex.advanced(by: 1)

        if nextIndex < textFields.count {
            textFields[nextIndex].textField.becomeFirstResponder()
        } else if nextIndex == textFields.count {
            textFields[currentIndex].textField.resignFirstResponder()
        }

        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkValues()
    }
}
