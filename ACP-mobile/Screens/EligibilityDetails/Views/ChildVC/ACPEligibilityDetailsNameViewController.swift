//
//  ACPEligibilityDetailsNameViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

class ACPEligibilityDetailsNameViewController: UIViewController {

    // MARK: - Properties

    var viewModel: ACPEligibilityDetailsViewModel?
    weak var delegate: ACPTabMenuDelegate?

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

    private lazy var nameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_details_name")
        view.textField.delegate = self
        return view
    }()

    private lazy var middleNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.attributedText = attributedTitleText()
        view.textField.delegate = self
        return view
    }()

    private lazy var lastNameTextField: ACPTextField = {
        let view = ACPTextField()
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

    private lazy var nextButton: ACPImageButton = {
        let button = ACPImageButton(
            titleKey: "eligibility_details_btn",
            spacing: Constants.Constraints.ButtonContentSpacing,
            cornerRadius: Constants.Constraints.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.isUserInteractionEnabled = false
        button.backgroundColor = .lavenderGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        showValuesIfPresent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addKeyboardObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        removeKeyboardObserver()
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(nameTextField)
        view.addSubview(middleNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(noBlankLabel)
        view.addSubview(nextButton)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffsetVertical)
        }

        nameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.NameOffsetVertical)
        }

        middleNameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(nameTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        lastNameTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(middleNameTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        noBlankLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(lastNameTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(noBlankLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
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
        guard let viewModel = viewModel?.model.nameModel else {
            return
        }

        nameTextField.textField.text = viewModel.name
        middleNameTextField.textField.text = viewModel.middleName
        lastNameTextField.textField.text = viewModel.lastName
    }

    // MARK: - Callback

    @objc func didTapButton() {
        guard let name = nameTextField.textField.text, name != "" else {
            return
        }
        viewModel?.model.nameModel.name = name

        if let middleName = middleNameTextField.textField.text {
            viewModel?.model.nameModel.middleName = middleName
        }

        guard let lastName = lastNameTextField.textField.text, lastName != "" else {
            return
        }

        viewModel?.model.nameModel.lastName = lastName

        delegate?.didTapNextButton()
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ContentInsetVertical: CGFloat = 60
            static let ContentInsetHorizontal: CGFloat = 35

            static let SubtitleOffsetVertical: CGFloat = 10

            static let NameOffsetVertical: CGFloat = 30
            static let TextFieldOffsetVertical: CGFloat = 10

            static let ButtonHeight: CGFloat = 46
            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10
            static let ButtonOffsetVertical: CGFloat = 60
        }
    }
}

// MARK: - UITextFieldDelegate

extension ACPEligibilityDetailsNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField.textField {
            middleNameTextField.textField.becomeFirstResponder()
        } else if textField == middleNameTextField.textField {
            lastNameTextField.textField.becomeFirstResponder()
        } else {
            lastNameTextField.textField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let lastname = lastNameTextField.textField.text,
              let name = nameTextField.textField.text
        else { return }

        let isEnabled = lastname != "" && name != ""

        nextButton.isUserInteractionEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }
}
