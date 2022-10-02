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

    func addRightImage(imageName: String) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false

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
