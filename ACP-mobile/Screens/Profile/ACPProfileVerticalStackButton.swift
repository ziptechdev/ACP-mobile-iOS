//
//  ACPProfileVerticalStackButton.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 13. 10. 2022..
//

import UIKit
import SnapKit

class ACPProfileVerticalStackButton: UIView {

    private let leftImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let buttonText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .gray06Dark
        return label
    }()

    private let rightImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        view.transform = view.transform.rotated(by: .pi * 1.5)
        return view
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        layer.borderWidth = Constants.Constraints.BorderWidth
        layer.cornerRadius = Constants.Constraints.CornerRadius
        layer.borderColor = UIColor.gray03Light.cgColor
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        addSubview(leftImageView)
        addSubview(buttonText)
        addSubview(rightImageView)
    }

    private func setupConstraints() {
        leftImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Constraints.LeftImageViewTopOffest)
            make.left.equalToSuperview().offset(Constants.Constraints.LeftImageViewLeftOffest)
        }

        buttonText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Constraints.ButtonTopOffest)
            make.left.equalTo(leftImageView.snp.right).offset(Constants.Constraints.ButtonLeftOffest)
        }

        rightImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Constraints.RightImageViewTopOffest)
            make.right.equalToSuperview().inset(Constants.Constraints.RightImageViewRightInset)
        }
    }

    func present(buttonTitle: String, leftImageName: String) {
        buttonText.text = buttonTitle
        leftImageView.image = UIImage(named: leftImageName)
        rightImageView.image = UIImage(named: "down_arrow")
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {

            static let LeftImageViewTopOffest: CGFloat = 11
            static let LeftImageViewLeftOffest: CGFloat = 20

            static let ButtonTopOffest: CGFloat = 13
            static let ButtonLeftOffest: CGFloat = 10

            static let RightImageViewTopOffest: CGFloat = 17
            static let RightImageViewRightInset: CGFloat = 20

            static let BorderWidth: CGFloat = 1.5
            static let CornerRadius: CGFloat = 10
        }
    }
}
