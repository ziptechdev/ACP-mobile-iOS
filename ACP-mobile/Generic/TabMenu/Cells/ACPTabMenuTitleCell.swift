//
//  ACPTabMenuTitleCell.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit
import SnapKit

class ACPTabMenuTitleCell: UICollectionViewCell {

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        isUserInteractionEnabled = true
        layer.masksToBounds = true
        layer.cornerRadius = Constants.Constraints.CornerRadius

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
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func configureCell(text: String) {
        titleLabel.text = text
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ContentInset: CGFloat = 4
            static let CornerRadius: CGFloat = 6
        }
    }
}

extension ACPTabMenuTitleCell: ACPFocusableView {
    func onActive() {
        contentView.backgroundColor = .white
        titleLabel.textColor = .gray06Dark
    }

    func onInactive() {
        contentView.backgroundColor = .clear
        titleLabel.textColor = .gray06Dark
    }

    func onDisable() {
        contentView.backgroundColor = .clear
        titleLabel.textColor = .gray03Light
    }
}
