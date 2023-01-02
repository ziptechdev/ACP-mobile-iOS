//
//  ACPProfileDOBView.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 2. 1. 2023..
//

import UIKit
import SnapKit

class ACPProfileDOBView: UIView {

    // MARK: - Properties
    var viewModel: ACPEligibilityDetailsViewModel?

    // MARK: - Views

    let DOBSectionTitle: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "profile_personal_dob_section")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var monthTextField: ACPPickerView = {
        let view = ACPPickerView()
        view.titleLabel.text = .localizedString(key: "eligibility_dob_month")
        view.textField.addRightImage(named: "down_arrow")
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    lazy var dayTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_dob_day")
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    lazy var yearTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_dob_year")
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        showValuesIfPresent()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        addSubview(DOBSectionTitle)
        addSubview(monthTextField)
        addSubview(dayTextField)
        addSubview(yearTextField)
    }

    private func setupConstraints() {
        DOBSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
        }

        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(DOBSectionTitle.snp.bottom).offset(Constants.Constraints.MonthTopOffset)
            make.left.equalTo(snp.left)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(Constants.Constraints.DayTopOffset)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.centerX).inset(Constants.Constraints.TextFieldSpacing / 2)
            make.width.equalTo(Constants.Constraints.LRFieldWidth)
        }

        yearTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(Constants.Constraints.YearTopOffset)
            make.left.equalTo(snp.centerX).offset(Constants.Constraints.TextFieldSpacing / 2)
            make.right.equalTo(snp.left)
            make.width.equalTo(Constants.Constraints.LRFieldWidth)
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
    }

    // MARK: - Callback

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard var text = textField.text else { return }
        switch textField {
        case dayTextField.textField:
            text = String(text.prefix(2))
        default: text = String(text.prefix(4))
            }
        textField.text = text
    }

    // MARK: - Constants
    struct Constants {
        struct Constraints {
            static let LROffset = 35
            static let mainWidth = 320
            static let TextFieldSpacing = 20

            static let DOBSectionTopOffset = 30
            static let MonthTopOffset = 10
            static let DayTopOffset = 10
            static let YearTopOffset = 10

            static let LRFieldWidth: CGFloat = 150
        }
    }
}

// MARK: - UIPickerViewDelegate

extension ACPProfileDOBView: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.model.dobModel.monthOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.model.dobModel.month = row
        monthTextField.textField.text = viewModel?.model.dobModel.monthOptions[row]
    }
}

// MARK: - UIPickerViewDelegate

extension ACPProfileDOBView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.model.dobModel.monthOptions.count ?? 0
    }
}
