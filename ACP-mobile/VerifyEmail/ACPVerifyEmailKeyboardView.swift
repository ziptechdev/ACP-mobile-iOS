//
//  ACPVerifyEmailKeyboardView.swift
//  ACP-mobile
//
//  Created by Adi on 11/10/2022.
//

import UIKit
import SnapKit

protocol ACPVerifyEmailKeyboardViewDelegate: AnyObject {
    func didPressKey()
    func didPressDelete()
}

class ACPVerifyEmailKeyboardView: UIView {

	// MARK: - Properties

    weak var delegate: ACPVerifyEmailKeyboardViewDelegate?

    // MARK: - Views

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

        setupKeyboard()
    }

    private func setupKeyboard() {
        var topConstraint = snp.top

        for i in 0...3 {
            for j in 1...3 {
                let newKey = setupKey(i: i, j: j, top: topConstraint)

                if j == 3 {
                    topConstraint = newKey.snp.bottom
                }

                if j == 3 && i == 3 {
                    newKey.snp.makeConstraints { make in
                        make.bottom.equalToSuperview()
                        make.right.equalToSuperview()
                    }
                }
            }
        }
    }

    private func setupKey(i: Int, j: Int, top: ConstraintItem) -> UIView {
        let value = i * 3 + j
        let label = UILabel()
        // TODO: Add Real Labels and callbacks
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(value)"
        label.font = .systemFont(ofSize: 28, weight: .regular)
        label.textAlignment = .center
        addSubview(label)

        label.snp.makeConstraints { make in
            make.top.equalTo(top)
            make.width.height.equalTo(75)
            if j == 1 {
                make.left.equalToSuperview()
            } else if j == 2 {
                make.centerX.equalToSuperview()
            } else {
                make.right.equalToSuperview()
            }
        }

        return label
    }

    // MARK: - Callbacks

    // MARK: - Constants

    private struct Constants {

    }
}
