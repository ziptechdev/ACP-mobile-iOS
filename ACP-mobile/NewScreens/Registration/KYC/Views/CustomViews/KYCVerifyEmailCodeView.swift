//
//  KYCVerifyEmailCodeView.swift
//  ACP-mobile
//
//  Created by Adi on 11/10/2022.
//

import UIKit
import SnapKit

class KYCVerifyEmailCodeView: UIView {

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

    private lazy var stackView = UIStackView(
        subviews: inputLabels,
        axis: .horizontal,
        distribution: .equalSpacing
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
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews()
        setupConstraints()

        setText(code: "")
    }

    private func addSubviews() {
        addSubview(stackView)
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        inputLabels.forEach({ inputLabel in
            inputLabel.snp.makeConstraints { make in
                make.height.width.equalTo(Constants.InputSize)
            }
        })
    }

    private func makeInputLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .regular)
        label.textColor = .gray06Dark
        label.textAlignment = .center
        label.layer.borderColor = UIColor.gray01Light.withAlphaComponent(0.5).cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = Constants.InputCornerRadius
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
        static let InputSize: CGFloat = 50
        static let InputCornerRadius: CGFloat = 10
    }
}