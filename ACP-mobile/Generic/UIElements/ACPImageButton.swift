//
//  ACPImageButton.swift
//  ACP-mobile
//
//  Created by Adi on 29/09/2022.
//

import UIKit

class ACPImageButton: UIButton {

    init(titleKey: String? = nil,
         font: UIFont? = nil,
         horizontal: CGFloat = 0,
         spacing: CGFloat,
         cornerRadius: CGFloat,
         imageName: String,
         textColor: UIColor = .white,
         isLeft: Bool = false
    ) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        semanticContentAttribute = isLeft ? .forceLeftToRight : .forceRightToLeft

        if #available(iOS 15.0, *) {
            configuration = .plain()

            configuration?.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: horizontal,
                bottom: 0,
                trailing: horizontal
            )

            configuration?.imagePadding = spacing
        } else {
            if isLeft {
                leftSetup(horizontal: horizontal, spacing: spacing)
            } else {
                rightSetup(horizontal: horizontal, spacing: spacing)
            }
        }

        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        tintColor = textColor

        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true

        if let titleKey = titleKey {
            setTitle(titleKey: titleKey, textColor: textColor, font: font)
        }

        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        setImage(image, for: .disabled)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func leftSetup(horizontal: CGFloat, spacing: CGFloat) {
        contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: horizontal,
            bottom: 0,
            right: horizontal + spacing
        )

        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: spacing,
            bottom: 0,
            right: -spacing
        )
    }

    private func rightSetup(horizontal: CGFloat, spacing: CGFloat) {
        contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: horizontal + spacing,
            bottom: 0,
            right: horizontal
        )

        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -spacing,
            bottom: 0,
            right: spacing
        )
    }
}
