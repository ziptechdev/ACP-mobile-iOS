//
//  ACPPersonalInfoViewControllerEldar.swift
//  ACP-mobile
//
//  Created by Abi  on 3. 11. 2022..
//

import UIKit

class ACPPersonalInfoViewControllerEldar: UIViewController {
  
    // MARK: - Properties
    var viewModel: ACPEligibilityDetailsViewModel?

    // MARK: - Views
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.MainTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let nameSectionTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.FullNameSection
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var nameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.FirstName
        return view
    }()

    private lazy var middleNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.attributedText = attributedTitleText()
        return view
    }()

    private lazy var lastNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.LastName
        return view
    }()

    private let DOBSectionTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.DOBSection
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var monthTextField: ACPPickerView = {
        let view = ACPPickerView()
        view.titleLabel.text = Constants.Text.Month
        view.textField.addRightImage(named: "down_arrow")
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    private lazy var dayTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.Day
        view.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    private lazy var yearTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.Year
        view.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    private let addressSectionTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.AddressSection
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var streetTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.StreetNumberName
        view.textField.delegate = self
        return view
    }()

    private lazy var cityTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.City
        view.textField.delegate = self
        return view
    }()

    private lazy var stateTextField: ACPPickerView = {
        let view = ACPPickerView()
        view.titleLabel.text = Constants.Text.State
        view.textField.addRightImage(named: "down_arrow")
        view.delegate = self
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    private lazy var zipTextField: ACPTextField = {
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

    private let SSNSectionTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.AddressSection
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var ssnTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.SSN
        view.delegate = self
        view.textField.keyboardType = .numberPad
        view.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return view
    }()

    private lazy var scrolLView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.isPagingEnabled = true
      //  sv.bounces = true
       // sv.contentSize = self.view.frame.size
        return sv
    }()

    private lazy var saveButton: UIButton = {
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
       // title = Constants.Text.Title
        navigationController?.navigationBar.isHidden = true
  
        
        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
//        setupHamburgerBarButton()
//        setupNotificationsBarButton()
        addKeyboardObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        scrolLView.addSubview(contentView)
        
        
//        view.addSubview(scrolLView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameSectionTitle)
        contentView.addSubview(nameTextField)
        contentView.addSubview(middleNameTextField)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(DOBSectionTitle)
        contentView.addSubview(monthTextField)
        contentView.addSubview(dayTextField)
//        contentView.addSubview(yearTextField)
//        contentView.addSubview(addressSectionTitle)
//        contentView.addSubview(streetTextField)
//        contentView.addSubview(cityTextField)
//        contentView.addSubview(stateTextField)
//        contentView.addSubview(zipTextField)
//        contentView.addSubview(SSNSectionTitle)
//        contentView.addSubview(ssnTextField)
        contentView.addSubview(saveButton)
       // scrolLView.layer.zPosition = 999
        view.addSubview(scrolLView)

    }

    private func setupConstraints() {
        
        scrolLView.snp.makeConstraints { make in
            make.width.centerX.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)

        }

        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.width.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Constraints.TitleTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
        }

        nameSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.NameSectionTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
        }
//
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameSectionTitle.snp.bottom).offset(Constants.Constraints.FullNameTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        middleNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(Constants.Constraints.MiddleNameTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }
//
        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(middleNameTextField.snp.bottom).offset(Constants.Constraints.LastNameTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }
//
        DOBSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(Constants.Constraints.DOBSectionTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
        }

        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(DOBSectionTitle.snp.bottom).offset(Constants.Constraints.MonthTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
         //   make.width.equalTo(Constants.Constraints.mainWidth)
        }

        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(Constants.Constraints.DayTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
            make.right.equalTo(view.snp.centerX).inset(Constants.Constraints.TextFieldSpacing / 2)
          //  make.width.equalTo(Constants.Constraints.LRFieldWidth)
        }
//
//        yearTextField.snp.makeConstraints { make in
//            make.top.equalTo(monthTextField.snp.bottom).offset(Constants.Constraints.YearTopOffset)
//            make.left.equalTo(view.snp.centerX).offset(Constants.Constraints.TextFieldSpacing / 2)
//            make.right.equalToSuperview().inset(Constants.Constraints.LROffset)
//            make.width.equalTo(Constants.Constraints.LRFieldWidth)
//        }
//
//        addressSectionTitle.snp.makeConstraints { make in
//            make.top.equalTo(yearTextField.snp.bottom).offset(Constants.Constraints.AddressSectionTopOffset)
//            make.left.equalToSuperview().offset(Constants.Constraints.LROffset)
//        }
//
//        streetTextField.snp.makeConstraints { make in
//            make.top.equalTo(addressSectionTitle.snp.bottom).offset(Constants.Constraints.AddressTopOffset)
//            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
//            make.width.equalTo(Constants.Constraints.mainWidth)
//        }
//
//        cityTextField.snp.makeConstraints { make in
//            make.top.equalTo(streetTextField.snp.bottom).offset(Constants.Constraints.CityTopOffset)
//            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
//            make.width.equalTo(Constants.Constraints.mainWidth)
//        }
//
//        stateTextField.snp.makeConstraints { make in
//            make.top.equalTo(cityTextField.snp.bottom).offset(Constants.Constraints.StateTopOffset)
//            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
//            make.right.equalTo(view.snp.centerX).inset(Constants.Constraints.TextFieldSpacing / 2)
//            make.width.equalTo(Constants.Constraints.LRFieldWidth)
//        }
//
//        zipTextField.snp.makeConstraints { make in
//            make.top.equalTo(cityTextField.snp.bottom).offset(Constants.Constraints.ZIPTopOffset)
//            make.left.equalTo(view.snp.centerX).offset(Constants.Constraints.TextFieldSpacing / 2)
//            make.right.equalToSuperview().inset(Constants.Constraints.LROffset)
//            make.width.equalTo(Constants.Constraints.LRFieldWidth)
//        }
//
//        SSNSectionTitle.snp.makeConstraints { make in
//            make.top.equalTo(zipTextField.snp.bottom).offset(Constants.Constraints.SSNSectionTopOffset)
//            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
//        }
//
//        ssnTextField.snp.makeConstraints { make in
//            make.top.equalTo(SSNSectionTitle.snp.bottom).offset(Constants.Constraints.SSNTopOffset)
//            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
//            make.width.equalTo(Constants.Constraints.mainWidth)
//        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(Constants.Constraints.ButtonTopOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.LROffset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.width.equalTo(Constants.Constraints.mainWidth)
            make.bottom.equalToSuperview()
        }

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
    // MARK: - Constants

    private struct Constants {
        struct Constraints {

            static let LROffset = 35
            static let mainWidth = 320
            static let TextFieldSpacing = 20

            static let TitleTopOffset = 60

            static let NameSectionTopOffset = 26
            static let FullNameTopOffset = 10
            static let MiddleNameTopOffset = 10
            static let LastNameTopOffset = 10

            static let DOBSectionTopOffset = 30
            static let MonthTopOffset = 10
            static let DayTopOffset = 10
            static let YearTopOffset = 10

            static let AddressSectionTopOffset = 30
            static let AddressTopOffset = 10
            static let CityTopOffset = 10
            static let StateTopOffset = 10
            static let ZIPTopOffset = 10

            static let SSNSectionTopOffset = 10
            static let SSNTopOffset = 10

            static let ButtonTopOffset = 10
            static let ButtonHeight: CGFloat = 46
            static let ButtonCornerRadius: CGFloat = 10

            static let LRFieldWidth: CGFloat = 150
        }

        struct Text {
            static let Title = "Profile"
            static let MainTitle = "Personal information"
            static let FullNameSection = "Name"
            static let FirstName = "First Name"
            static let MiddleName = "Middle Name"
            static let LastName = "Last Name"
            static let DOBSection = "Date of Birth"
            static let Month = "Month"
            static let Day = "Day"
            static let Year = "Year"
            static let AddressSection = "Address"
            static let StreetNumberName = "Street Number and Name"
            static let City = "City"
            static let State = "State"
            static let ZIPCode = "ZIP Code"
            static let ZipPlaceholder = "92805 - 1483"
            static let SSN = "SSN (Social Security Number)"
            static let SaveButtonText = "Save"
        }
    }
}

// MARK: - UITextFieldDelegate

extension ACPPersonalInfoViewControllerEldar: UITextFieldDelegate {
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

extension ACPPersonalInfoViewControllerEldar: ACPToolbarDelegate {
    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}

// MARK: - UIPickerViewDelegate

extension ACPPersonalInfoViewControllerEldar: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.model.dobModel.monthOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.model.dobModel.month = row
        monthTextField.textField.text = viewModel?.model.dobModel.monthOptions[row]
    }
}

// MARK: - UIPickerViewDelegate

extension ACPPersonalInfoViewControllerEldar: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.model.dobModel.monthOptions.count ?? 0
    }
}
