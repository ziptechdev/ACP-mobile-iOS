//
//  ACPTabMenuImageCell.swift
//  ACP-mobile
//
//  Created by Adi on 25/10/2022.
//

import UIKit
import SnapKit

struct ACPTabMenuImageCellModel {
    let title: String
    let imageName: String
}

class ACPTabMenuImageCell: UICollectionViewCell {

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.Constraints.CornerRadius
        view.layer.masksToBounds = true
        return view
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        isUserInteractionEnabled = true
        layer.masksToBounds = true

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
        contentView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.Constraints.ContainerSize)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(Constants.Constraints.ContentInset)
        }

        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Constraints.ImageSize)
            make.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerView.snp.bottom).offset(Constants.Constraints.TitleOffset)
            make.bottom.equalToSuperview().inset(Constants.Constraints.ContentInset)
        }
    }

    func configureCell(title: String, imageName: String) {
        titleLabel.text = title
        imageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let CornerRadius: CGFloat = 10
            static let ImageSize: CGFloat = 20
            static let ContainerSize: CGFloat = 45
            static let ContentInset: CGFloat = 20
            static let TitleOffset: CGFloat = 5
        }
    }
}

extension ACPTabMenuImageCell: ACPFocusableView {
    func onActive() {
        imageView.tintColor = .coreBlue
        containerView.backgroundColor = .coreLightBlue
        titleLabel.textColor = .gray06Dark
    }

    func onInactive() {
        imageView.tintColor = .gray03Light
        containerView.backgroundColor = .clear
        titleLabel.textColor = .gray03Light
    }

    func onDisable() {
        imageView.tintColor = .gray03Light
        containerView.backgroundColor = .clear
        titleLabel.textColor = .gray03Light
    }
}
