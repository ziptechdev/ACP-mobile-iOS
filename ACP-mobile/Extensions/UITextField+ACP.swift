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
    let imageWidth: CGFloat = 30
    lazy var imagePadding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20 + imageWidth)

    var textFieldImage: UIImageView? {
        if let subviews = rightView?.subviews {
            let view = subviews.first(where: { $0 is UIImageView })
            if let imageView = view as? UIImageView {
                return imageView
            }
        }
        return nil
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        if textFieldImage != nil {
            return bounds.inset(by: imagePadding)
        }
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if textFieldImage != nil {
            return bounds.inset(by: imagePadding)
        }
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        if textFieldImage != nil {
            return bounds.inset(by: imagePadding)
        }
        return bounds.inset(by: padding)
    }

    func addRightImage(named: String, imageColor: UIColor? = nil) {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true

        if let tintColor = imageColor {
            imageView.image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = tintColor
        } else {
            imageView.image = UIImage(named: named)
        }

        let imageContainerView = UIView()
        imageContainerView.isUserInteractionEnabled = true
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(30)
        }

        rightView = imageContainerView
        rightViewMode = .always
    }
}
