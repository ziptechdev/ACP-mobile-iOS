//
//  ACPImageButton.swift
//  ACP-mobile
//
//  Created by Adi on 29/09/2022.
//

import UIKit

class ACPImageButton: UIButton {

    init(vertical: CGFloat = 8,
         horizontal: CGFloat = 20,
         spacing: CGFloat = 4,
         isLeft: Bool = false
    ) {
        super.init(frame: .zero)

        semanticContentAttribute = isLeft ? .forceLeftToRight : .forceRightToLeft

        if #available(iOS 15.0, *) {
            configuration = .plain()

            configuration?.contentInsets = NSDirectionalEdgeInsets(
                top: vertical,
                leading: horizontal,
                bottom: vertical,
                trailing: horizontal
            )

            configuration?.imagePadding = spacing
        } else {
            if isLeft {
                leftSetup(vertical: vertical, horizontal: horizontal, spacing: spacing)
            } else {
                rightSetup(vertical: vertical, horizontal: horizontal, spacing: spacing)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func leftSetup(vertical: CGFloat, horizontal: CGFloat, spacing: CGFloat) {
        contentEdgeInsets = UIEdgeInsets(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal + spacing
        )

        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: spacing,
            bottom: 0,
            right: -spacing
        )
    }

    private func rightSetup(vertical: CGFloat, horizontal: CGFloat, spacing: CGFloat) {
        contentEdgeInsets = UIEdgeInsets(
            top: vertical,
            left: horizontal + spacing,
            bottom: vertical,
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
