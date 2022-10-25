//
//  ACPSuccesViewController.swift
//  ACP-mobile
//
//  Created by Abi  on 18. 10. 2022..
//

import UIKit
import SnapKit

class ACPSuccesViewController: UIViewController {

    // MARK: - Views

    private let successImage: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "successACP")
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        view.image = image
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "successfull_title")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "acp_successfull_desc")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(.localizedString(key: "acp_successfull_register_btn"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .coreBlue

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(successImage)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(doneButton)
    }

    private func setupConstraints() {
        successImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.SuccessCircleOffsetY)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constants.Constraints.CircleSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(successImage.snp.bottom).offset(Constants.Constraints.TitleOffsetVertical)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffsetY)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
        }

        doneButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }
    }

    // MARK: - Callbacks

    @objc func didTapCancel() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func didTapRegisterButton() {
        let viewController = ApplyACPViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let SuccessCircleOffsetY: CGFloat = 175
            static let CircleSize: CGFloat = 120

            static let TitleOffsetVertical: CGFloat = 113

            static let ContentInsetHorizontal: CGFloat = 35
            static let SubtitleOffsetY: CGFloat = 10

            static let ButtonHeight: CGFloat = 46
            static let ButtonOffsetVertical: CGFloat = 60
            static let ButtonCornerRadius: CGFloat = 10
        }
    }
}
