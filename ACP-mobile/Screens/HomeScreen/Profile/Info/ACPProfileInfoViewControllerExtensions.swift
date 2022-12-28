//
//  ACPProfileInfoViewControllerExtensions.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 15. 12. 2022..
//

import UIKit

// MARK: - UITextFieldDelegate

extension ACPProfileInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            middleNameTextField.textField.becomeFirstResponder()
        } else if textField == middleNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            monthTextField.textField.becomeFirstResponder()
        } else if textField == monthTextField.textField {
            dayTextField.textField.becomeFirstResponder()
        } else if textField == dayTextField.textField {
            yearTextField.textField.becomeFirstResponder()
        } else if textField == yearTextField.textField {
            cityTextField.textField.becomeFirstResponder()
        } else if textField == streetTextField {
            stateTextField.textField.becomeFirstResponder()
        } else if textField == cityTextField {
            zipTextField.textField.becomeFirstResponder()
        } else {
            ssnTextField.textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - ACPToolbarDelegate

extension ACPProfileInfoViewController: ACPToolbarDelegate {
    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}

// MARK: - UIPickerViewDelegate

extension ACPProfileInfoViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.model.dobModel.monthOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.model.dobModel.month = row
        monthTextField.textField.text = viewModel?.model.dobModel.monthOptions[row]
    }
}

// MARK: - UIPickerViewDelegate

extension ACPProfileInfoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.model.dobModel.monthOptions.count ?? 0
    }
}
