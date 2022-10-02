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

    private lazy var streetTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.Street
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
        view.textField.addRightImage(imageName: "down_arrow")
        view.delegate = self
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
        return view
    }()

    private lazy var zipTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = Constants.Text.Zip
        view.delegate = self
        view.textField.delegate = self
        view.textField.attributedPlaceholder = NSAttributedString(
            string: Constants.Text.ZipPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray01Dark]
        )
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
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

    private lazy var verifyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Text.Verify, for: .normal)
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

    // MARK: - Initialization

    init(_ delegate: ACPEligibilityDetailsDelegate) {
        super.init(nibName: nil, bundle: nil)

        self.delegate = delegate
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
            make.top .equalTo(noBlankLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }
    }

    // MARK: - Callback

    @objc func didTapButton() {
        delegate?.didTapVerifyButton()
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
            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10
            static let ButtonOffsetVertical: CGFloat = 60
        }

        struct Text {
            static let Title = "Your home address"
            static let Subtitle = """
            The address where you will get service.
            Do not use a P.O. Box.
            """
            static let Verify = "Verify"
            static let Blank = "*Cannot be left blank"
            static let Street = "Street Number and Name*"
            static let City = "City*"
            static let State = "State*"
            static let Zip = "ZIP Code"
            static let ZipPlaceholder = "92805 - 1483"
        }
    }
}

// MARK: - UITextFieldDelegate

extension ACPEligibilityDetailsAddressViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == streetTextField.textField {
            cityTextField.textField.becomeFirstResponder()
        } else if textField == cityTextField.textField {
            stateTextField.textField.becomeFirstResponder()
        } else if textField == stateTextField.textField {
            zipTextField.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - ACPPickerViewDelegate

extension ACPEligibilityDetailsAddressViewController: ACPToolbarDelegate {

    func didPressDone(_ textfield: UITextField) {
        _ = textFieldShouldReturn(textfield)
    }
}

// MARK: - UIPickerViewDelegate

extension ACPEligibilityDetailsAddressViewController: UIPickerViewDelegate {

    func pickerView(
        _ pickerView: UIPickerView,
        attributedTitleForRow row: Int,
        forComponent component: Int
    ) -> NSAttributedString? {
        return NSAttributedString(string: "Test")
    }
}

// MARK: - UIPickerViewDelegate

extension ACPEligibilityDetailsAddressViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
}
