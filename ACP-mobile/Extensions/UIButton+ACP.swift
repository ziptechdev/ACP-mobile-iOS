//
//  UIButton+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 25/10/2022.
//

import UIKit

extension UIButton {
    func setTitle(titleKey: String, textColor: UIColor = .white, font: UIFont? = nil) {
        let titleFont = font ?? UIFont.systemFont(ofSize: 17, weight: .semibold)
        let attributedTitle: NSMutableAttributedString = .localizedString(key: titleKey)
        attributedTitle.addAttribute(.font, value: titleFont)
        attributedTitle.addAttribute(.foregroundColor, value: textColor)
        setAttributedTitle(attributedTitle, for: .normal)
        setAttributedTitle(attributedTitle, for: .normal)
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
