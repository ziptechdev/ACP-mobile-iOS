//
//  String+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 17/10/2022.
//

import UIKit

extension String {
    static func localizedString(key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }

    static func formatLocalizedString(key: String, values: CVarArg...) -> String {
        return String(format: .localizedString(key: key), values)
    }

    func range(of subString: String) -> NSRange {
        let string = NSString(string: self)
        return string.range(of: subString)
    }
}

extension NSMutableAttributedString {
    static func localizedString(key: String) -> NSMutableAttributedString {
        let string = NSLocalizedString(key, comment: key)
        return NSMutableAttributedString(string: string)
    }

    static func formatLocalizedString(key: String, values: CVarArg...) -> NSMutableAttributedString {
        let string = String(format: .localizedString(key: key), values)
        return NSMutableAttributedString(string: string)
    }

    func range(of subString: String) -> NSRange {
        return self.mutableString.range(of: subString)
    }

    func addAttribute(_ name: NSAttributedString.Key, value: Any) {
        let fullRange = NSRange(location: 0, length: self.length)
        addAttribute(name, value: value, range: fullRange)
    }

    static func subtitleString(
        key: String,
        color: UIColor = .gray01Light,
        isCenter: Bool = false
    ) -> NSMutableAttributedString {
        let subtitle: NSMutableAttributedString = .localizedString(key: key)
        let paragraphStyle: NSMutableParagraphStyle = isCenter ? .center : .lineHeight

        subtitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular))
        subtitle.addAttribute(.paragraphStyle, value: paragraphStyle)
        subtitle.addAttribute(.foregroundColor, value: color)

        return subtitle
    }
}
