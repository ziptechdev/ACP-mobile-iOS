//
//  UITextField+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 02/10/2022.
//

import UIKit
import SnapKit

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UITextField {

    func addRightImage(named: String, imageColor: UIColor? = nil) {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        if let tintColor = imageColor {
            imageView.image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = tintColor
        } else {
            imageView.image = UIImage(named: named)
        }

        let imageContainerView = UIView()
        imageContainerView.isUserInteractionEnabled = false
        imageContainerView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().offset(1)
        }

        rightView = imageContainerView
        rightViewMode = .always
    }
}
