//
//  ACPPickerView.swift
//  ACP-mobile
//
//  Created by Adi on 02/10/2022.
//

import UIKit
import SnapKit

protocol ACPToolbarDelegate: AnyObject {
    func didPressDone(_ textfield: UITextField)
}

class ACPPickerView: UIView, TextInput {

    // MARK: - Properties

    weak var delegate: ACPToolbarDelegate?

    var isEmpty: Bool {
        let textFieldEmpty = textField.text?.isEmpty ?? true
        return textFieldEmpty
    }

    var text: String {
        return textField.text ?? ""
    }

    // MARK: - Views

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray06Dark
        return label
    }()

    let textField: TextField = {
        let view = TextField()
        view.isPicker = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.Constraints.TextFieldRoundedCorners
        view.layer.masksToBounds = true
        view.autocorrectionType = .no
        view.tintColor = .clear
        view.layer.borderWidth = Constants.Constraints.TextFieldBorderWidth
        view.layer.borderColor = UIColor.gray03Light.cgColor
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = .gray06Dark
        return view
    }()

    let pickerView = UIPickerView()

    private lazy var pickerToolbar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: "Next",
            style: .done,
            target: self,
            action: #selector(donePicker)
        )

        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        return toolBar
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()

        textField.inputView = pickerView
        textField.inputAccessoryView = pickerToolbar
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
        addSubview(titleLabel)
        addSubview(textField)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }

        textField.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(Constants.Constraints.TextFieldHeight)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.TextFieldOffset)
        }
    }

    // MARK: - Callback

    @objc private func donePicker() {
        delegate?.didPressDone(textField)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let TextFieldOffset: CGFloat = 6
            static let TextFieldBorderWidth: CGFloat = 1.5
            static let TextFieldRoundedCorners: CGFloat = 10
            static let TextFieldHeight: CGFloat = 45
        }
    }
}
