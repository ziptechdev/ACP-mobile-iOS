//
//  EligibilityDetailsAddressViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

class EligibilityDetailsAddressViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: EligibilityDetailsViewModel
    weak var delegate: TabMenuDelegate?

    private lazy var textFields: [TextInput] = [
        streetTextField, cityTextField, stateTextField
    ]

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "eligibility_address_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(key: "eligibility_address_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var streetTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_street")
        view.textField.delegate = self
        return view
    }()

    private lazy var cityTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_city")
        view.textField.delegate = self
        return view
    }()

    private lazy var stateTextField: PickerView = {
        let view = PickerView()
        view.titleLabel.text = .localizedString(key: "eligibility_address_state")
        view.textField.addRightImage(named: "down_arrow")
        view.delegate = self
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    private lazy var zipTextField: TextField = {
        let view = TextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_zip")
        view.textField.textAlignment = .center
        view.isUserInteractionEnabled = false
        return view
    }()

    private let noBlankLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "eligibility_address_info")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray01Light
        return label
    }()

    private lazy var verifyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = .lavenderGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "eligibility_address_btn")
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
        subviews: [stateTextField, zipTextField],
        axis: .horizontal,
        distribution: .fillEqually,
        spacing: Constants.dualFieldStackViewSpacing
    )

    private lazy var fieldsStackView = UIStackView(
        subviews: [
            streetTextField,
            cityTextField,
            dualFieldStackView,
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
        view.addSubview(verifyButton)
    }

    private func setupConstraints() {
        topStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.top.equalToSuperview().inset(Constants.ContentInsetVertical)
        }

        verifyButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(topStackView.snp.bottom).offset(Constants.ButtonOffsetVertical)
        }
    }

    // MARK: - Presenting

    private func showValuesIfPresent() {
        streetTextField.textField.text = viewModel.model.address
        cityTextField.textField.text = viewModel.model.city
        pickerView(stateTextField.pickerView, didSelectRow: viewModel.model.selectedState, inComponent: 0)
        zipTextField.textField.text = viewModel.model.zipCode

        checkValues()
    }

    private func checkValues() {
        let isEnabled = textFields.allSatisfy({ !$0.isEmpty })

        verifyButton.isUserInteractionEnabled = isEnabled
        verifyButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }

    // MARK: - Callback

    @objc func didTapButton() {
        viewModel.model.address = streetTextField.text
        viewModel.model.city = cityTextField.text

        delegate?.didTapActionButton()
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
        static let ButtonCornerRadius: CGFloat = 10
        static let ButtonOffsetVertical: CGFloat = 60
    }
}

// MARK: - UITextFieldDelegate

extension EligibilityDetailsAddressViewController: UITextFieldDelegate {

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

// MARK: - ToolbarDelegate

extension EligibilityDetailsAddressViewController: ToolbarDelegate {

    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}

// MARK: - UIPickerViewDelegate

extension EligibilityDetailsAddressViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.stateOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.model.selectedState = row
        stateTextField.textField.text = viewModel.stateOptions[row]
    }
}

// MARK: - UIPickerViewDelegate

extension EligibilityDetailsAddressViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.stateOptions.count
    }
}
