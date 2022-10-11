//
//  ACPTextField.swift
//  ACP-mobile
//
//  Created by Adi on 02/10/2022.
//

import UIKit
import SnapKit

class ACPTextField: UIView {

    // MARK: - Properties

    weak var delegate: ACPToolbarDelegate? {
        didSet {
            textField.inputAccessoryView = toolbar
        }
    }

    var textFieldImage: UIImageView? {
        if let subviews = textField.rightView?.subviews {
            let view = subviews.first(where: { $0 is UIImageView })
            if let imageView = view as? UIImageView {
                return imageView
            }
        }
        return nil
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
