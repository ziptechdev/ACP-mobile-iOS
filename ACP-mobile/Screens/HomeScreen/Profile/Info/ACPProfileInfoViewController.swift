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
        label.text = Constants.Text.MainTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    let nameSectionTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.FullNameSection
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var nameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.FirstName
        return view
    }()

    lazy var middleNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.attributedText = attributedTitleText()
        return view
    }()

    lazy var lastNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.LastName
        return view
    }()

    let DOBSectionTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.DOBSection
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var monthTextField: ACPPickerView = {
        let view = ACPPickerView()
        view.titleLabel.text = Constants.Text.Month
        view.textField.addRightImage(named: "down_arrow")
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    lazy var dayTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.Day
        view.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    lazy var yearTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.Year
        view.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    let addressSectionTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.AddressSection
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var streetTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.StreetNumberName
        view.textField.delegate = self
        return view
    }()

    lazy var cityTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.City
        view.textField.delegate = self
        return view
    }()

    lazy var stateTextField: ACPPickerView = {
        let view = ACPPickerView()
        view.titleLabel.text = Constants.Text.State
        view.textField.addRightImage(named: "down_arrow")
        view.delegate = self
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    lazy var zipTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.ZIPCode
        view.delegate = self
        view.textField.delegate = self
        view.textField.attributedPlaceholder = NSAttributedString(
            string: Constants.Text.ZipPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray01Dark]
        )
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    let SSNSectionTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.AddressSection
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var ssnTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.SSN
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
        button.setTitle(Constants.Text.SaveButtonText, for: .normal)
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = Constants.Text.Title
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
        let string = NSMutableAttributedString(string: Constants.Text.MiddleName)
        string.addAttribute(.foregroundColor, value: UIColor.gray06Dark, range: fullRange)
        return string
    }

    // MARK: - Presenting

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
