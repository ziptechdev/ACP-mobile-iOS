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
}

extension NSString {
    static func localizedString(key: String) -> NSString {
        return NSLocalizedString(key, comment: key) as NSString
    }
}

extension NSMutableAttributedString {
    static func localizedString(key: String) -> NSMutableAttributedString {
        let string = NSLocalizedString(key, comment: key)
        return NSMutableAttributedString(string: string)
    }
}
