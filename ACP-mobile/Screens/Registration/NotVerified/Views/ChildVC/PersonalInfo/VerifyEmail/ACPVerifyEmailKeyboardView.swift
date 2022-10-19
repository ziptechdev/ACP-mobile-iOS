//
//  ACPVerifyEmailKeyboardView.swift
//  ACP-mobile
//
//  Created by Adi on 11/10/2022.
//

import UIKit
import SnapKit

protocol ACPVerifyEmailKeyboardViewDelegate: AnyObject {
    func didPressKey(key: String)
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
                if let newKey = setupKey(i: i, j: j, top: topConstraint) {

                    // Set new constraint
                    if j == 3 {
                        topConstraint = newKey.snp.bottom
                    }

                    // Set constraints for the last button
                    if j == 3 && i == 3 {
                        newKey.snp.makeConstraints { make in
                            make.bottom.equalToSuperview()
                            make.right.equalToSuperview()
                        }
                    }
                }
            }
        }
    }

    private func setupKey(i: Int, j: Int, top: ConstraintItem) -> UIView? {
        let value = i * 3 + j

        guard value != 10 else {
            return nil
        }

        let view: UIView
        if value == 12 {
            let imageView = UIImageView()
            let image = UIImage(named: "backspace")
            imageView.image = image
            imageView.contentMode = .center
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDelete))
            imageView.addGestureRecognizer(tap)
            view = imageView
        } else {
            let label = UILabel()
            // Set 0 for 11th key
            label.text = value == 11 ? "0" : "\(value)"
            label.tag = value == 11 ? 0 : value
            label.font = .systemFont(ofSize: 28, weight: .regular)
            label.textAlignment = .center
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapKey(_:)))
            label.addGestureRecognizer(tap)
            view = label
        }

        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        addSubview(view)

        view.snp.makeConstraints { make in
            make.top.equalTo(top)
            make.width.equalToSuperview().inset(Constants.Constraints.KeySpacing).dividedBy(3)
            make.height.equalTo(view.snp.width)
            if j == 1 {
                make.left.equalToSuperview()
            } else if j == 2 {
                make.centerX.equalToSuperview()
            } else {
                make.right.equalToSuperview()
            }
        }

        return view
    }

    // MARK: - Callbacks

    @objc func didTapDelete() {
        delegate?.didPressDelete()
    }

    @objc func didTapKey(_ sender: UITapGestureRecognizer) {
        guard let number = sender.view?.tag else {
            return
        }

        delegate?.didPressKey(key: "\(number)")
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let KeySpacing: CGFloat = 10
        }
    }
}
