//
//  ACPTopTabMenuButton.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

enum TabButtonStatus {
    case selected
    case active
    case inactive
}

class ACPTopTabMenuButton: UIView {

	// MARK: - Properties

    var status: TabButtonStatus {
        didSet {
            updateStyle()
        }
    }

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

    init(status: TabButtonStatus = .inactive) {
        self.status = status

        super.init(frame: .zero)

        backgroundColor = .white
        isUserInteractionEnabled = true
        layer.masksToBounds = true
        layer.cornerRadius = Constants.Constraints.CornerRadius

        setupUI()

        updateStyle()
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
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
        }
    }

    private func updateStyle() {
        switch status {
        case .selected:
            backgroundColor = .white
            titleLabel.textColor = .gray06Dark
        case .active:
            backgroundColor = .clear
            titleLabel.textColor = .gray06Dark
        case .inactive:
            backgroundColor = .clear
            titleLabel.textColor = .gray03Light
        }
    }

    func setText(text: String) {
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
