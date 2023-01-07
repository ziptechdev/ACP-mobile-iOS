//
//  BorderedView.swift
//  ACP-mobile
//
//  Created by Adi on 18/10/2022.
//

import UIKit
import SnapKit

class BorderedView: UIView {

    // MARK: - Views

     let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initialization

    init(imageName: String) {
        super.init(frame: .zero)

        setupUI()

        imageView.image = UIImage(named: imageName)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        backgroundColor = .coreLightBlue
        layer.cornerRadius = Constants.Constraints.CornerRadius
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews()
        setupConstraints()

        setupCorners()
    }

    private func addSubviews() {
        addSubview(imageView)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(Constants.Constraints.ImageSize)
        }
    }

    private func setupCorners() {
        setupCornerView(isLeft: true, isTop: true, rotation: 0)
        setupCornerView(isLeft: true, isTop: false, rotation: 3 * .pi / 2)
        setupCornerView(isLeft: false, isTop: true, rotation: .pi / 2)
        setupCornerView(isLeft: false, isTop: false, rotation: .pi)
    }

    private func setupCornerView(isLeft: Bool, isTop: Bool, rotation: CGFloat) {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "corner")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.transform = view.transform.rotated(by: rotation)

        addSubview(view)

        view.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.Constraints.CornerSize)
            if isLeft {
                make.left.equalToSuperview().offset(-1)
            } else {
                make.right.equalToSuperview().offset(1)
            }

            if isTop {
                make.top.equalToSuperview().offset(-1)
            } else {
                make.bottom.equalToSuperview().offset(1)
            }
        }
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let CornerRadius: CGFloat = 10
            static let ImageSize: CGFloat = 36
            static let CornerSize: CGFloat = 18
        }
    }
}
