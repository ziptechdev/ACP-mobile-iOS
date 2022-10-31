//
//  ACPShadowButton.swift
//  ACP-mobile
//
//  Created by Adi on 30/10/2022.
//

import UIKit

class ACPShadowButton: UIButton {
    var hasShadow = true

    private var shadowAdded: Bool = false

    var shadowLayer = CALayer()

    override var backgroundColor: UIColor? {
        didSet {
            shadowLayer.shadowColor = backgroundColor?.cgColor
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        guard hasShadow else { return }

        guard !shadowAdded else { return }

        shadowAdded = true

        let shadowColor = isUserInteractionEnabled ? backgroundColor : .clear

        let shadow = UIView()
        shadow.frame = bounds
        shadow.clipsToBounds = false

        let shadowPath = UIBezierPath(roundedRect: shadow.bounds, cornerRadius: 10)
        shadowLayer = CALayer()
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.shadowColor = shadowColor?.cgColor
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowRadius = 30
        shadowLayer.shadowOffset = CGSize(width: 0, height: 12)
        shadowLayer.bounds = shadow.bounds
        shadowLayer.position = center
        shadow.layer.addSublayer(shadowLayer)

        guard let superView = superview else { return }

        superView.addSubview(shadow)
        superView.bringSubviewToFront(self)
    }
}
