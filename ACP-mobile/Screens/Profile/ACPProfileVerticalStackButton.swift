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
            make.top.equalToSuperview().offset(11)
            make.left.equalToSuperview().offset(20)
        }

        buttonText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalTo(leftImageView.snp.right).offset(10)
        }

        rightImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.right.equalToSuperview().inset(20)
        }
    }

    func present(buttonTitle: String, leftImageName: String) {
        buttonText.text = buttonTitle
        leftImageView.image = UIImage(named: leftImageName)
        rightImageView.image = UIImage(named: "down_arrow")
    }
}
