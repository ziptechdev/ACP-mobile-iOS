//
//  UIStackView+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 11/12/2022.
//

import UIKit

extension UIStackView {
    func addArrangedSubview(_ subView: UIView, withInset inset: UIEdgeInsets) {
        let container = UIView()
        container.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: container.topAnchor, constant: inset.top),
            subView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: inset.bottom),
            subView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: inset.left),
            subView.rightAnchor.constraint(equalTo: container.rightAnchor, constant: inset.right)
        ])

        addArrangedSubview(container)
    }

    convenience init(
        subviews: [UIView] = [],
        axis: NSLayoutConstraint.Axis = .vertical,
        distribution: Distribution = .fill,
        alignment: Alignment = .fill,
        spacing: CGFloat = 0
    ) {
        self.init(arrangedSubviews: subviews)

        translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}
