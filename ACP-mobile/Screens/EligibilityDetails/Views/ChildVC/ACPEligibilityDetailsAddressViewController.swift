//
//  ACPEligibilityDetailsAddressViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

class ACPEligibilityDetailsAddressViewController: UIViewController {

    // MARK: - Properties

    var viewModel: ACPEligibilityDetailsViewModel?
    weak var delegate: ACPTabMenuDelegate?

    private lazy var textFields: [TextInput] = [
        streetTextField, cityTextField, stateTextField, zipTextField
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

    private lazy var streetTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_street")
        view.textField.delegate = self
        return view
    }()

    private lazy var cityTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_city")
        view.textField.delegate = self
        return view
    }()

    private lazy var stateTextField: ACPPickerView = {
        let view = ACPPickerView()
        view.titleLabel.text = .localizedString(key: "eligibility_address_state")
        view.textField.addRightImage(named: "down_arrow")
        view.delegate = self
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    private lazy var zipTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_zip")
        view.delegate = self
        view.textField.delegate = self
        view.textField.attributedPlaceholder = NSAttributedString(
            string: .localizedString(key: "eligibility_address_placeholder"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray01Dark]
        )
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = .lavenderGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "eligibility_address_btn")
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
        view.addSubview(streetTextField)
        view.addSubview(cityTextField)
        view.addSubview(stateTextField)
        view.addSubview(zipTextField)
        view.addSubview(noBlankLabel)
        view.addSubview(verifyButton)
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

        streetTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.StreetOffsetVertical)
        }

        cityTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(streetTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        stateTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.right.equalTo(view.snp.centerX).inset(Constants.Constraints.TextFieldSpacing / 2)
            make.top.equalTo(cityTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        zipTextField.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.left.equalTo(view.snp.centerX).offset(Constants.Constraints.TextFieldSpacing / 2)
            make.top.equalTo(cityTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        noBlankLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(zipTextField.snp.bottom).offset(Constants.Constraints.SubtitleOffsetVertical)
        }

        verifyButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(noBlankLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }
    }

    // MARK: - Presenting

    private func showValuesIfPresent() {
        guard let viewModel = viewModel?.model.addressModel else {
            return
        }

        streetTextField.textField.text = viewModel.address
        cityTextField.textField.text = viewModel.city
        pickerView(stateTextField.pickerView, didSelectRow: viewModel.state, inComponent: 0)
        zipTextField.textField.text = viewModel.zipCode
    }

    // MARK: - Callback

    @objc func didTapButton() {
        viewModel?.model.addressModel.address = streetTextField.text
        viewModel?.model.addressModel.city = cityTextField.text
//        viewModel?.model.addressModel.state
        viewModel?.model.addressModel.zipCode = zipTextField.text

        delegate?.didTapActionButton()
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard var text = textField.text else {
            return
        }

        text = text.replacingOccurrences(of: " ", with: "")
        text = text.replacingOccurrences(of: "-", with: "")

        if text.count >= 6 {
            let separator = " - "
            let separatorIndex = text.index(text.startIndex, offsetBy: 5)
            text.insert(contentsOf: separator, at: separatorIndex)
        }

        textField.text = String(text.prefix(12))
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ContentInsetVertical: CGFloat = 60
            static let ContentInsetHorizontal: CGFloat = 35

            static let SubtitleOffsetVertical: CGFloat = 10

            static let StreetOffsetVertical: CGFloat = 30
            static let TextFieldOffsetVertical: CGFloat = 10
            static let TextFieldSpacing: CGFloat = 20

            static let ButtonHeight: CGFloat = 46
            static let ButtonCornerRadius: CGFloat = 10
            static let ButtonOffsetVertical: CGFloat = 60
        }
    }
}

// MARK: - UITextFieldDelegate

extension ACPEligibilityDetailsAddressViewController: UITextFieldDelegate {

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
        let isEnabled = textFields.allSatisfy({ !$0.isEmpty })

        verifyButton.isUserInteractionEnabled = isEnabled
        verifyButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray
    }
}

// MARK: - ACPToolbarDelegate

extension ACPEligibilityDetailsAddressViewController: ACPToolbarDelegate {

    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}

// MARK: - UIPickerViewDelegate

extension ACPEligibilityDetailsAddressViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.model.addressModel.stateOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.model.addressModel.state = row
        stateTextField.textField.text = viewModel?.model.addressModel.stateOptions[row]
    }
}

// MARK: - UIPickerViewDelegate

extension ACPEligibilityDetailsAddressViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.model.addressModel.stateOptions.count ?? 0
    }
}
