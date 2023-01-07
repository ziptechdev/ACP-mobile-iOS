//
//  EligibilityDetailsDOBViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

class EligibilityDetailsDOBViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: EligibilityDetailsViewModel
    weak var delegate: TabMenuDelegate?

    private lazy var textFields: [TextInput] = [
        monthTextField, dayTextField, yearTextField, ssnTextField
    ]

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "eligibility_dob_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(key: "eligibility_dob_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var monthTextField: PickerView = {
        let view = PickerView()
        view.titleLabel.text = .localizedString(key: "eligibility_dob_month")
        view.textField.addRightImage(named: "down_arrow")
        view.delegate = self
        view.textField.delegate = self
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    private lazy var dayTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "eligibility_dob_day")
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    private lazy var yearTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "eligibility_dob_year")
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    private lazy var ssnTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "eligibility_dob_ssn")
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    private let noBlankLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "eligibility_dob_info")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray01Light
        return label
    }()

    private lazy var nextButton: ImageButton = {
        let button = ImageButton(
            titleKey: "eligibility_dob_btn",
            spacing: Constants.ButtonContentSpacing,
            cornerRadius: Constants.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.isUserInteractionEnabled = false
        button.backgroundColor = .lavenderGray
        button.translatesAutoresizingMaskIntoConstraints = false
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

    private lazy var dualFieldStackView = UIStackView(
        subviews: [dayTextField, yearTextField],
        axis: .horizontal,
        distribution: .fillEqually,
        spacing: Constants.dualFieldStackViewSpacing
    )

    private lazy var fieldsStackView = UIStackView(
        subviews: [
            monthTextField,
            dualFieldStackView,
            ssnTextField,
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
        hideKeyboardWhenTappedAround()
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

    // MARK: - Presenting

    private func showValuesIfPresent() {
        pickerView(monthTextField.pickerView, didSelectRow: viewModel.model.selectedMonth, inComponent: 0)
        dayTextField.textField.text = viewModel.model.day
        yearTextField.textField.text = viewModel.model.year
        ssnTextField.textField.text = viewModel.model.ssn

        checkValues()
    }

    private func checkValues() {
        let isEnabled = textFields.allSatisfy({ !$0.isEmpty })

        nextButton.isUserInteractionEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }

    // MARK: - Callback

    @objc func didTapButton() {
        viewModel.model.day = dayTextField.text
        viewModel.model.year = yearTextField.text
        viewModel.model.ssn = ssnTextField.text

        if viewModel.isDateOfBirthValid {
            delegate?.didTapNextButton()
        } else {
            UIAlertController.showErrorAlert(message: "Please enter a valid date of birth", from: self)
        }
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard var text = textField.text else {
            return
        }

        switch textField {
        case dayTextField.textField:
            text = String(text.prefix(2))

        default:
            text = String(text.prefix(4))

        }

        textField.text = text
    }

    // MARK: - Constants

    private struct Constants {
        static let ContentInsetVertical: CGFloat = 60
        static let ContentInsetHorizontal: CGFloat = 35

        static let titleStackViewSpacing: CGFloat = 10
        static let fieldsStackViewSpacing: CGFloat = 10
        static let dualFieldStackViewSpacing: CGFloat = 20
        static let topStackViewSpacing: CGFloat = 30

        static let ButtonHeight: CGFloat = 46
        static let ButtonContentSpacing: CGFloat = 10
        static let ButtonCornerRadius: CGFloat = 10
        static let ButtonOffsetVertical: CGFloat = 60
    }
}

// MARK: - UITextFieldDelegate

extension EligibilityDetailsDOBViewController: UITextFieldDelegate {
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

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return textField != monthTextField.textField
    }
}

// MARK: - ToolbarDelegate

extension EligibilityDetailsDOBViewController: ToolbarDelegate {
    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}

// MARK: - UIPickerViewDelegate

extension EligibilityDetailsDOBViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.monthOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.model.selectedMonth = row
        monthTextField.textField.text = viewModel.monthOptions[row]
    }
}

// MARK: - UIPickerViewDelegate

extension EligibilityDetailsDOBViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.monthOptions.count
    }
}
