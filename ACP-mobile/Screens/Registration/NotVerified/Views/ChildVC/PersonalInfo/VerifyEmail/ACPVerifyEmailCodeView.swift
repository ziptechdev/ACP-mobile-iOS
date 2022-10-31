//
//  ACPVerifyEmailCodeView.swift
//  ACP-mobile
//
//  Created by Adi on 11/10/2022.
//

import UIKit
import SnapKit

class ACPVerifyEmailCodeView: UIView {

	// MARK: - Properties

    private lazy var inputLabels = [
        firstNumberLabel,
        secondNumberLabel,
        thirdNumberLabel,
        fourthNumberLabel,
        fifthNumberLabel
    ]

    // MARK: - Views

    private lazy var firstNumberLabel = makeInputLabel()
    private lazy var secondNumberLabel = makeInputLabel()
    private lazy var thirdNumberLabel = makeInputLabel()
    private lazy var fourthNumberLabel = makeInputLabel()
    private lazy var fifthNumberLabel = makeInputLabel()

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
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews()
        setupConstraints()

        setText(code: "")
    }

    private func addSubviews() {
        addSubview(firstNumberLabel)
        addSubview(secondNumberLabel)
        addSubview(thirdNumberLabel)
        addSubview(fourthNumberLabel)
        addSubview(fifthNumberLabel)
    }

    private func setupConstraints() {
        firstNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(firstNumberLabel.snp.width)
        }

        secondNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(firstNumberLabel.snp.right).offset(Constants.Constraints.InputSpacing)
            make.height.equalTo(secondNumberLabel.snp.width)
        }

        thirdNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(secondNumberLabel.snp.right).offset(Constants.Constraints.InputSpacing)
            make.height.equalTo(thirdNumberLabel.snp.width)
        }

        fourthNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(thirdNumberLabel.snp.right).offset(Constants.Constraints.InputSpacing)
            make.height.equalTo(fourthNumberLabel.snp.width)
        }

        fifthNumberLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(fourthNumberLabel.snp.right).offset(Constants.Constraints.InputSpacing)
            make.right.equalToSuperview()
            make.height.equalTo(fifthNumberLabel.snp.width)
        }
    }

    private func makeInputLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .regular)
        label.textColor = .gray06Dark
        label.textAlignment = .center
        label.layer.borderColor = UIColor.gray01Light.withAlphaComponent(0.5).cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = Constants.Constraints.InputCornerRadius
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func setText(code: String) {
        var didFocus = false
        let numbers = Array(code)
        inputLabels.enumerated().forEach { (index, label) in
            label.layer.borderColor = UIColor.gray01Light.withAlphaComponent(0.2).cgColor

            if index < code.count {
                label.text = "\(numbers[index])"
            } else {
                if !didFocus {
                    didFocus = true
                    label.layer.borderColor = UIColor.coreBlue.cgColor
                }
                label.text = ""
            }
        }
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let InputSpacing: CGFloat = 10
            static let InputCornerRadius: CGFloat = 10
        }
    }
}
