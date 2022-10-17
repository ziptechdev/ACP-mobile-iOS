//
//  EgibilityZipView.swift
//  ACP-mobile
//
//  Created by Abi  on 4. 10. 2022..
//

import UIKit
import SnapKit

protocol EgibilityZipCodeDelegate: AnyObject {
    func didTapNextButton()
    func didPressDone(_ textfield: UITextField, _ secondTextfield: UITextField)
}

// TODO: Body Length Fix
class EgibilityZipView: UIView {

    // MARK: - Delegates

    weak var delegate: EgibilityZipCodeDelegate? {
        didSet {
            zipFirstCodeTextField.inputAccessoryView = toolbar
            zipSecondCodeTextField.inputAccessoryView = toolbar
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coreBlue
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionTexLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray01Light
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()

    let zipLabelName: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var zipFirstCodeTextField: UITextField = {
        let zipTextField = UITextField()
        zipTextField.adjustsFontSizeToFitWidth = true
        zipTextField.autocorrectionType = .no
        zipTextField.keyboardType = .numberPad
        zipTextField.returnKeyType = .done
        zipTextField.contentVerticalAlignment = .center
        zipTextField.textAlignment = .center
        return zipTextField
    }()

    var zipSecondCodeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.none
        textField.adjustsFontSizeToFitWidth = true
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        textField.returnKeyType = .done
        textField.contentVerticalAlignment = .center
        textField.textAlignment = .center
        return textField
    }()

    let zipCodeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 1
        stackView.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        stackView.layer.borderWidth = 2.0
        stackView.layer.borderColor = UIColor.gray03Light.cgColor
        return stackView
    }()

    private let customLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray03Light
        return view
    }()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .warningRed
        label.font = UIFont(name: "Poppins", size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nextButton: ACPImageButton = {
        let button = ACPImageButton(
            spacing: Constants.Constraints.ButtonContentSpacing,
            cornerRadius: Constants.Constraints.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.backgroundColor = .lavenderGray
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        // shadow for button
        button.layer.shadowColor = UIColor.lavenderGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        button.layer.shadowOpacity = 0.0
        button.layer.shadowRadius = 20.0
        button.layer.masksToBounds = false
        return button
    }()

    private let buttonAndInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 30
        return stackView
    }()

    lazy var toolbar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(donePicker)
        )

        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        return toolBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setUpConstraints()
        setText()

        nextButton.addTarget(self, action: #selector(checkEgibilityTapped), for: .touchUpInside)
        zipFirstCodeTextField.addTarget(self, action: #selector(zipCodeFirstHandler), for: .editingChanged)
        zipSecondCodeTextField.addTarget(self, action: #selector(zipCodeSecondHandler), for: .editingChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func addSubviews() {
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(descriptionTexLabel)

        zipCodeStackView.addArrangedSubview(zipFirstCodeTextField)
        zipCodeStackView.addArrangedSubview(customLine)
        zipCodeStackView.addArrangedSubview(zipSecondCodeTextField)

        buttonAndInfoStackView.addArrangedSubview(nextButton)

        addSubview(zipLabelName)
        addSubview(errorLabel)
        addSubview(textStackView)
        addSubview(zipCodeStackView)
        addSubview(zipCodeStackView)
        addSubview(buttonAndInfoStackView)
    }

    @objc func checkEgibilityTapped(sender: UIButton!) {
        delegate?.didTapNextButton()
    }

    @objc private func zipCodeFirstHandler() {
        if let t: String = zipFirstCodeTextField.text {
            zipFirstCodeTextField.text = String(t.prefix(5))
        }

        zipFirstCodeTextField.attributedText = attributedTitleText(
            attributeText: zipFirstCodeTextField.text!,
            spacing: 18
        )
    }

    @objc private func zipCodeSecondHandler() {
        if let t: String = zipSecondCodeTextField.text {
            zipSecondCodeTextField.text = String(t.prefix(4))
        }

        zipSecondCodeTextField.attributedText = attributedTitleText(
            attributeText: zipSecondCodeTextField.text!,
            spacing: 10
        )
    }

    func setVisibilityForValidZipCode() {
        nextButton.isUserInteractionEnabled = true
        nextButton.backgroundColor = .coreBlue
        nextButton.layer.shadowOpacity = 1.0
        errorLabel.isHidden = true
        zipCodeStackView.layer.borderColor = UIColor.coreBlue.cgColor
    }

    func setVisibilityForInvalidZipCode() {
        nextButton.isUserInteractionEnabled = false
        nextButton.backgroundColor = .lavenderGray
        nextButton.layer.shadowOpacity = 0.0
        errorLabel.isHidden = false
        zipCodeStackView.layer.borderColor = UIColor.warningRed.cgColor
    }

    private func attributedTitleText(attributeText: String, spacing: Int) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.kern: spacing]
        let string = NSMutableAttributedString(string: attributeText, attributes: attributes)
        return string
    }

    // MARK: - Callback

    @objc private func donePicker() {
        delegate?.didPressDone(zipFirstCodeTextField, zipSecondCodeTextField)
    }

    private func setUpConstraints() {
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }

        zipCodeStackView.snp.makeConstraints { make in
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }

        customLine.snp.makeConstraints { make in
            make.height.equalTo(Constants.Constraints.LeadingConstant)
            make.width.equalTo(Constants.Constraints.DividerLineViewWidth)
        }

        zipSecondCodeTextField.snp.makeConstraints { make in
            make.width.equalTo(Constants.Constraints.SecondTextFieldWidth)
        }

        textStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(Constants.Constraints.TopConstant)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }

        zipLabelName.snp.makeConstraints { make in
            make.top.equalTo(textStackView.snp.bottom).offset(Constants.Constraints.ButtonHeight)
            make.left.equalTo(zipCodeStackView.snp.left)
        }

        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(zipCodeStackView.snp.bottom).offset(Constants.Constraints.TopErrorConstant)
            make.left.equalTo(zipCodeStackView.snp.left)
        }

        zipCodeStackView.snp.makeConstraints { make in
            make.top.equalTo(zipLabelName.snp.bottom).offset(Constants.Constraints.ZipCodeTextFieldTopConstant)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }

        buttonAndInfoStackView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom).inset(Constants.Constraints.BottomButtonSpacingConstant)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }
    }

    private func setText() {
        titleLabel.text = .localizedString(key: "eligibility_zip_title")
        descriptionTexLabel.text = .localizedString(key: "eligibility_zip_details")
        zipLabelName.text = .localizedString(key: "eligibility_zip_label")
        errorLabel.text = .localizedString(key: "eligibility_zip_error")
        nextButton.setTitle(.localizedString(key: "eligibility_zip_btn"), for: .normal)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let TopConstant: CGFloat = 60
            static let LeadingConstant: CGFloat = 30
            static let TrailingConstant: CGFloat = 20
            static let BottomButtonSpacingConstant: CGFloat = 85
            static let SecondTextFieldWidth: CGFloat = 140
            static let DividerLineViewWidth: CGFloat = 2
            static let TopErrorConstant: CGFloat = 10
            static let ZipCodeTextFieldTopConstant: CGFloat = 6
            static let ButtonHeight: CGFloat = 46
            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10
            static let TitleBotOffset: CGFloat = 10
        }
    }
}
