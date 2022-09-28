//
//  ACPHomeScreenTableHeaderView.swift
//  ACP-mobile
//
//  Created by Adi on 28/09/2022.
//

import UIKit
import SnapKit

class ACPHomeScreenTableHeaderView: UITableViewHeaderFooterView {

	// MARK: - Properties

    // MARK: - Views

    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = Constants.Constraints.ImageCornerRadius
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private let isVerifiedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    // MARK: - UI

    func setupUI() {
        addSubviews()
        setupConstraints()

        profileImageView.backgroundColor = .red
        nameLabel.text = "John Doe"
    }

    private func addSubviews() {
        addSubview(profileImageView)
    }

    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Constraints.ImageInsetTop)
            make.bottom.equalToSuperview().inset(Constants.Constraints.ImageInsetBot)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(Constants.Constraints.ImageSize)
        }
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ImageInsetTop: CGFloat = 50
            static let ImageInsetBot: CGFloat = 150
            static let ImageSize: CGFloat = 96
            static let ImageCornerRadius: CGFloat = 30
        }
    }
}
