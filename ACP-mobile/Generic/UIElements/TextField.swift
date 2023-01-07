//
//  TextField.swift
//  ACP-mobile
//
//  Created by Adi on 02/10/2022.
//

import UIKit
import SnapKit

protocol TextInput: AnyObject {
    var isEmpty: Bool { get }
    var text: String { get }
    var textField: ACPTextField { get }
}

class TextField: UIView, TextInput {

    // MARK: - Properties

    var isEmpty: Bool {
        let textFieldEmpty = textField.text?.isEmpty ?? true
        return textFieldEmpty
    }

    var text: String {
        return textField.text ?? ""
    }

    private var isErrorShowing = false

    weak var delegate: ToolbarDelegate? {
        didSet {
            textField.inputAccessoryView = toolbar
        }
    }

    var textFieldImage: UIImageView? {
        return textField.textFieldImage
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

    let textField: ACPTextField = {
        let view = ACPTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.Constraints.TextFieldRoundedCorners
        view.layer.masksToBounds = true
        view.autocorrectionType = .no
        view.layer.borderWidth = Constants.Constraints.TextFieldBorderWidth
        view.layer.borderColor = UIColor.gray03Light.cgColor
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.autocorrectionType = .no
        view.textColor = .gray06Dark
        return view
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .warningRed
        label.isHidden = true
        return label
    }()

    private lazy var toolbar: UIToolbar = {
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

    private lazy var stackView = UIStackView(
        subviews: [
            titleLabel,
            textField,
            errorLabel
        ],
        spacing: Constants.Constraints.TextFieldOffset
    )

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
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
        addSubview(stackView)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }

        textField.snp.makeConstraints { make in
            make.height.equalTo(Constants.Constraints.TextFieldHeight)
        }
    }

    func showError(message: String) {
        textField.layer.borderColor = UIColor.warningRed.cgColor
        errorLabel.isHidden = false
        errorLabel.text = message
    }

    func hideError() {
        textField.layer.borderColor = UIColor.gray03Light.cgColor
        errorLabel.isHidden = true
        errorLabel.text = ""
    }

    func toggleSecureEntry() {
        textField.isSecureTextEntry.toggle()

        let imageName = textField.isSecureTextEntry ? "eye_open" : "eye_closed"

        if let textFieldImage = textFieldImage {
            textFieldImage.image = UIImage(named: imageName)
        } else {
            textField.addRightImage(named: imageName)
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
