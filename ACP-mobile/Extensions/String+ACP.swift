//
//  String+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 17/10/2022.
//

import Foundation

extension String {
    static func localizedString(key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }

    static func formatLocalizedString(key: String, values: CVarArg...) -> String {
        return String(format: .localizedString(key: key), values)
    }
}

extension NSString {
    static func localizedString(key: String) -> NSString {
        return NSLocalizedString(key, comment: key) as NSString
    }

    static func formatLocalizedString(key: String, values: CVarArg...) -> NSString {
        return String(format: .localizedString(key: key), values) as NSString
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
}
