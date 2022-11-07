//
//  RequestCardViewController.swift
//  ACP-mobile
//
//  Created by Abi  on 30. 10. 2022..
//

import UIKit
import SnapKit

class RequestCardViewController: UIViewController {

    // MARK: - Properties
    var viewModel: RequestCardViewModel?

    private lazy var textFields: [TextInput] = [
        firstNameTextField, lastNameTextField, streetTextField, cityTextField, stateTextField, zipTextField, phoneTextField
    ]
    private lazy var textFieldsACP: [ACPTextField] = [
        firstNameTextField, lastNameTextField, streetTextField, cityTextField, zipTextField, phoneTextField, firstNameTextField, lastNameTextField
    ]
    private var isEditable = false

    // MARK: - Views

    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .white
        return sv
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "request_card_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(key: "request_card_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()

    private lazy var firstNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "request_card_first_name")
        view.textField.delegate = self
        return view
    }()
    private lazy var lastNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "request_card_last_name")
        view.textField.delegate = self
        return view
    }()

    private lazy var streetTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "request_card_street_num")
        view.textField.delegate = self
        return view
    }()

    private lazy var cityTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "request_card_city")
        view.textField.delegate = self
        return view
    }()

    private lazy var stateTextField: ACPPickerView = {
        let view = ACPPickerView()
        view.titleLabel.text = .localizedString(key: "request_card_state")
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

    private lazy var phoneTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "personal_info_phone")
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        return view
    }()

    private lazy var editButton: ACPImageButton = {
        let button = ACPImageButton(
            spacing: Constants.Constraints.ButtonCornerRadius,
            cornerRadius: Constants.Constraints.ButtonCornerRadius,
            imageName: "edit",
            textColor: .coreBlue,
            isLeft: true
        )
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.borderColor = UIColor.coreBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.localizedString(key: "edit_btn"), for: .normal)
        button.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        return button
    }()

    private lazy var requestCardButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "request_card_btn")
        button.addTarget(self, action: #selector(didTapRequestCardButton), for: .touchUpInside)
        return button
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "request_card_save_btn")
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        enabledTextFields()
        showValuesIfPresent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = .localizedString(key: "my_wallet_title")
        navigationController?.navigationBar.isHidden = false

        setupHamburgerBarButton()
        setupNotificationsBarButton()
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
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(firstNameTextField)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(streetTextField)
        contentView.addSubview(cityTextField)
        contentView.addSubview(stateTextField)
        contentView.addSubview(zipTextField)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(saveButton)
        contentView.addSubview(editButton)
        contentView.addSubview(requestCardButton)

        view.addSubview(scrollView)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.width.centerX.top.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.width.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalToSuperview().offset(Constants.Constraints.ContentInsetVertical)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffsetVertical)
        }
        firstNameTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.right.equalTo(view.snp.centerX).inset(Constants.Constraints.TextFieldSpacing / 2)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.StreetOffsetVertical)
        }
        lastNameTextField.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.left.equalTo(view.snp.centerX).offset(Constants.Constraints.TextFieldSpacing / 2)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.StreetOffsetVertical)
        }
        streetTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(firstNameTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
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

        phoneTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(zipTextField.snp.bottom).offset(Constants.Constraints.SubtitleOffsetVertical)
        }
        editButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(phoneTextField.snp.bottom).offset(Constants.Constraints.StreetOffsetVertical)
        }
        saveButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(phoneTextField.snp.bottom).offset(Constants.Constraints.StreetOffsetVertical)
        }
        requestCardButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(editButton.snp.bottom).offset(Constants.Constraints.StreetOffsetVertical)
            make.bottom.equalToSuperview().inset(Constants.Constraints.TextFieldSpacing)
        }
    }

    // MARK: - Presenting

    private func showValuesIfPresent() {
        guard let viewModel = viewModel else {
            return
        }
        firstNameTextField.textField.text = viewModel.firstName
        lastNameTextField.textField.text = viewModel.lastName
        streetTextField.textField.text = viewModel.address
        cityTextField.textField.text = viewModel.city
        pickerView(stateTextField.pickerView, didSelectRow: viewModel.state, inComponent: 0)
        zipTextField.textField.text = viewModel.zipCode
        phoneTextField.textField.text = viewModel.phoneNumber
    }

    // MARK: - Callback

    @objc func didTapSaveButton() {
        isEditable = false
        enabledTextFields()
        viewModel?.firstName = firstNameTextField.textField.text ?? ""
        viewModel?.address = streetTextField.textField.text ?? ""
        viewModel?.city = cityTextField.textField.text ?? ""
        viewModel?.zipCode = zipTextField.textField.text ?? ""
        viewModel?.phoneNumber = phoneTextField.textField.text ?? ""

    }
    @objc func didTapEdit() {
        isEditable = true
        enabledTextFields()

    }
    @objc func didTapRequestCardButton() {
        let targetVC = ACPSuccesCardViewController()
        navigationController?.pushViewController(targetVC, animated: true)
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

    private func enabledTextFields() {
        if isEditable {
            textFieldsACP.forEach { textFieldacp in
                if textFieldacp == firstNameTextField || textFieldacp == lastNameTextField {

                } else {
                    textFieldacp.textField.backgroundColor = .white
                    textFieldacp.textField.isUserInteractionEnabled = true
                    textFieldacp.textField.textColor = .gray06Dark
                }

            }

            stateTextField.textField.isUserInteractionEnabled = true
            stateTextField.textField.backgroundColor = .white
            saveButton.isHidden = false
            editButton.isHidden = true
            requestCardButton.isHidden = true

        } else {
            textFieldsACP.forEach { textFieldacp in
                textFieldacp.textField.backgroundColor = .gray06Light
                textFieldacp.textField.isUserInteractionEnabled = false
                textFieldacp.textField.textColor = .gray06Dark
            }
            stateTextField.textField.isUserInteractionEnabled = false
            stateTextField.textField.backgroundColor = .gray06Light

            saveButton.isHidden = true
            editButton.isHidden = false
            requestCardButton.isHidden = false
        }
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

extension RequestCardViewController: UITextFieldDelegate {

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
          saveButton.isUserInteractionEnabled = isEnabled
          saveButton.backgroundColor = isEnabled ? .coreBlue : .lavenderGray

    }
}

// MARK: - ACPToolbarDelegate

extension RequestCardViewController: ACPToolbarDelegate {

    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}

// MARK: - UIPickerViewDelegate

extension RequestCardViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.stateOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.state = row
        stateTextField.textField.text = viewModel?.stateOptions[row]
    }
}

// MARK: - UIPickerViewDelegate

extension RequestCardViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  viewModel?.stateOptions.count ?? 0
    }
}
