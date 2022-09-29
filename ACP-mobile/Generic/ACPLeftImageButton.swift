//
//  ACPLeftImageButton.swift
//  ACP-mobile
//
//  Created by Adi on 29/09/2022.
//

import UIKit

class ACPLeftImageButton: UIButton {

    init(vertical: CGFloat = 8, horizontal: CGFloat = 20, spacing: CGFloat = 4) {
        super.init(frame: .zero)

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
            contentEdgeInsets = UIEdgeInsets(
                top: vertical,
                left: horizontal,
                bottom: vertical,
                right: horizontal
            )

            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
