//
//  ACPTabMenuDotCell.swift
//  ACP-mobile
//
//  Created by Adi on 19/10/2022.
//

import UIKit
import SnapKit

class ACPTabMenuDotCell: UICollectionViewCell {

    // MARK: - Views

    private let dotView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray06Light
        view.layer.cornerRadius = Constants.Constraints.CornerRadius
        view.layer.masksToBounds = true
        return view
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
        contentView.addSubview(dotView)
    }

    private func setupConstraints() {
        dotView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().inset(Constants.Constraints.Inset)
            make.height.width.equalTo(Constants.Constraints.Size)
        }
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let CornerRadius: CGFloat = 5
            static let Size: CGFloat = 10
            static let Inset: CGFloat = 7.5
        }
    }
}

extension ACPTabMenuDotCell: ACPFocusableView {
    func onActive() {
        dotView.backgroundColor = .coreBlue
    }

    func onInactive() {
        dotView.backgroundColor = .gray06Light
    }

    func onDisable() {
        dotView.backgroundColor = .gray06Light
    }
}
