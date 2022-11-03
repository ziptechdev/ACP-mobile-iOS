//
//  NSMutableParagraphStyle+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit

extension NSMutableParagraphStyle {
    static var center: NSMutableParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineHeightMultiple = 1.2
        return style
    }()

    static var lineHeight: NSMutableParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.2
        return style
    }()
}
