//
//  ACPProfileInfoViewController.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 13. 10. 2022..
//

import UIKit

class ACPProfileInfoViewController: UIViewController {

    // MARK: - Properties
    var viewModel: ACPEligibilityDetailsViewModel?

    // MARK: - Views

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "profile_personal_info")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    let nameSectionTitle: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "profile_personal_name_section")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var nameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "personal_info_first_name")
        return view
    }()

    lazy var middleNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.attributedText = attributedTitleText()
        return view
    }()

    lazy var lastNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "personal_info_last_name")
        return view
    }()

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
        view.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    lazy var yearTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_dob_year")
        view.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    let addressSectionTitle: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "profile_personal_address_section")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var streetTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_street")
        view.textField.delegate = self
        return view
    }()

    lazy var cityTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_city")
        view.textField.delegate = self
        return view
    }()

    lazy var stateTextField: ACPPickerView = {
        let view = ACPPickerView()
        view.titleLabel.text = .localizedString(key: "eligibility_address_state")
        view.textField.addRightImage(named: "down_arrow")
        view.delegate = self
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    lazy var zipTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_zip")
        view.delegate = self
        view.textField.delegate = self
        view.textField.attributedPlaceholder = NSAttributedString(
            string: .localizedString(key: "profile_personal_address_placeholder"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray01Dark]
        )
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    let SSNSectionTitle: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "profile_personal_ssn_section")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var ssnTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_dob_ssn")
        view.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    lazy var scrolLView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.isPagingEnabled = true
        sv.bounces = true
        sv.contentSize = self.view.frame.size
        return sv
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.localizedString(key: "profile_personal_btn_save"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
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
        title = .localizedString(key: "profile_page_title")
        navigationController?.navigationBar.isHidden = false
        addKeyboardObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }

    private func attributedTitleText() -> NSMutableAttributedString {
        let middleName = Constants.Text.MiddleName as NSString
        let fullRange = NSRange(location: 0, length: middleName.length)
        let string = NSMutableAttributedString(string: .localizedString(key: "profile_personal_middle_name"))
        string.addAttribute(.foregroundColor, value: UIColor.gray06Dark, range: fullRange)
        return string
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
        print("save")
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard var text = textField.text else { return }
        switch textField {
        case dayTextField.textField:
            text = String(text.prefix(2))
        default: text = String(text.prefix(4))
            }
        textField.text = text
    }
}
