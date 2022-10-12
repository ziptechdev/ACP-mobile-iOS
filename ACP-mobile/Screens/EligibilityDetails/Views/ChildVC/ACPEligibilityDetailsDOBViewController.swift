//
//  ACPEligibilityDetailsDOBViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

class ACPEligibilityDetailsDOBViewController: UIViewController {

    // MARK: - Properties

    var viewModel: ACPEligibilityDetailsViewModel?
    weak var delegate: ACPEligibilityDetailsDelegate?

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.Title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.Subtitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray01Light
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var monthTextField: ACPPickerView = {
        let view = ACPPickerView()
        view.titleLabel.text = Constants.Text.Month
        view.textField.addRightImage(named: "down_arrow")
        view.delegate = self
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    private lazy var dayTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.Day
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    private lazy var yearTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.Year
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    private lazy var ssnTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.SSN
        view.delegate = self
        view.textField.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    private let noBlankLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.Blank
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray01Light
        return label
    }()

    private lazy var nextButton: ACPImageButton = {
        let button = ACPImageButton(
            spacing: Constants.Constraints.ButtonContentSpacing,
            cornerRadius: Constants.Constraints.ButtonCornerRadius,
            imageName: "right_arrow"
        )
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Text.Next, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
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
        view.addSubview(monthTextField)
        view.addSubview(dayTextField)
        view.addSubview(yearTextField)
        view.addSubview(ssnTextField)
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

        monthTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.MonthOffsetVertical)
        }

        dayTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.right.equalTo(view.snp.centerX).inset(Constants.Constraints.TextFieldSpacing / 2)
            make.top.equalTo(monthTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        yearTextField.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.left.equalTo(view.snp.centerX).offset(Constants.Constraints.TextFieldSpacing / 2)
            make.top.equalTo(monthTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        ssnTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(dayTextField.snp.bottom).offset(Constants.Constraints.TextFieldOffsetVertical)
        }

        noBlankLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.top.equalTo(ssnTextField.snp.bottom).offset(Constants.Constraints.SubtitleOffsetVertical)
        }

        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(noBlankLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }
    }

    // MARK: - Presenting

    private func showValuesIfPresent() {
        guard let viewModel = viewModel?.model.dobModel else {
            return
        }

        pickerView(monthTextField.pickerView, didSelectRow: viewModel.month, inComponent: 0)
        dayTextField.textField.text = viewModel.day
        yearTextField.textField.text = viewModel.year
        ssnTextField.textField.text = viewModel.ssn
    }

    // MARK: - Callback

    @objc func didTapButton() {
        guard let day = dayTextField.textField.text, day != "" else {
            return
        }
        viewModel?.model.dobModel.day = day

        guard let year = yearTextField.textField.text, year != "" else {
            return
        }
        viewModel?.model.dobModel.year = year

        guard let ssn = ssnTextField.textField.text, ssn != "" else {
            return
        }
        viewModel?.model.dobModel.ssn = ssn

        delegate?.didTapNextButton()
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
        struct Constraints {
            static let ContentInsetVertical: CGFloat = 60
            static let ContentInsetHorizontal: CGFloat = 35

            static let SubtitleOffsetVertical: CGFloat = 10

            static let MonthOffsetVertical: CGFloat = 30
            static let TextFieldOffsetVertical: CGFloat = 10
            static let TextFieldSpacing: CGFloat = 20

            static let ButtonHeight: CGFloat = 46
            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10
            static let ButtonOffsetVertical: CGFloat = 60
        }

        struct Text {
            static let Title = "Your date of birth"
            static let Subtitle = "This information is required by National Verifier to verify your identity."
            static let Next = "Next"
            static let Blank = "*Cannot be left blank"
            static let Month = "Month*"
            static let Day = "Day*"
            static let Year = "Year*"
            static let SSN = "SSN (Last 4 digits of your Social Security Number)*"
        }
    }
}

// MARK: - UITextFieldDelegate

extension ACPEligibilityDetailsDOBViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == monthTextField.textField {
            dayTextField.textField.becomeFirstResponder()
        } else if textField == dayTextField.textField {
            yearTextField.textField.becomeFirstResponder()
        } else if textField == yearTextField.textField {
            ssnTextField.textField.becomeFirstResponder()
        } else {
            ssnTextField.textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - ACPToolbarDelegate

extension ACPEligibilityDetailsDOBViewController: ACPToolbarDelegate {
    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}

// MARK: - UIPickerViewDelegate

extension ACPEligibilityDetailsDOBViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.model.dobModel.monthOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.model.dobModel.month = row
        monthTextField.textField.text = viewModel?.model.dobModel.monthOptions[row]
    }
}

// MARK: - UIPickerViewDelegate

extension ACPEligibilityDetailsDOBViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.model.dobModel.monthOptions.count ?? 0
    }
}
