//
//  KYCVerifyEmailKeyboardView.swift
//  ACP-mobile
//
//  Created by Adi on 11/10/2022.
//

import UIKit
import SnapKit

protocol KYCVerifyEmailKeyboardViewDelegate: AnyObject {
    func didPressKey(key: String)
    func didPressDelete()
}

class KYCVerifyEmailKeyboardView: UIView {

    // MARK: - Properties

    weak var delegate: KYCVerifyEmailKeyboardViewDelegate?

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
        let verticalStackView = UIStackView(
            distribution: .equalSpacing
        )
        for i in 0...3 {
            let horizontalStackView = UIStackView(
                axis: .horizontal,
                distribution: .equalSpacing
            )
            for j in 1...3 {
                let newKey = setupKey(i: i, j: j)
                newKey.snp.makeConstraints { make in
                    make.width.height.equalTo(Constants.KeySize)
                }
                horizontalStackView.addArrangedSubview(newKey)
            }
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
        addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

    private func setupKey(i: Int, j: Int) -> UIView {
        let value = i * 3 + j

        guard value != 10 else {
            return UIView()
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
        static let KeySize: CGFloat = 60
    }
}
