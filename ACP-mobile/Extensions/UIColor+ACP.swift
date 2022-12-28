//
//  UIColor+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 28/09/2022.
//

import UIKit

enum ColorEnum: String {
    case CoreBlue, Gray01Dark, Gray01Light, Gray03Light, Gray06Dark, Gray06Light, ACPYellow,
         WarningRed, SuccessGreen, LavenderGray, CoreLightBlue, CoreBrown, CoreLightPurple,
         CorePurple
}

extension UIColor {

    static func namedColor(_ name: String) -> UIColor {
        return UIColor(named: name) ?? .black
    }

    static let coreBlue = namedColor(ColorEnum.CoreBlue.rawValue)
    static let gray01Dark = namedColor(ColorEnum.Gray01Dark.rawValue)
    static let gray01Light = namedColor(ColorEnum.Gray01Light.rawValue)
    static let gray03Light = namedColor(ColorEnum.Gray03Light.rawValue)
    static let gray06Dark = namedColor(ColorEnum.Gray06Dark.rawValue)
    static let gray06Light = namedColor(ColorEnum.Gray06Light.rawValue)
    static let acpYellow = namedColor(ColorEnum.ACPYellow.rawValue)
    static let warningRed = namedColor(ColorEnum.WarningRed.rawValue)
    static let successGreen = namedColor(ColorEnum.SuccessGreen.rawValue)
    static let lavenderGray = namedColor(ColorEnum.LavenderGray.rawValue)
    static let coreLightBlue = namedColor(ColorEnum.CoreLightBlue.rawValue)
    static let coreBrown = namedColor(ColorEnum.CoreBrown.rawValue)
    static let coreLightPurple = namedColor(ColorEnum.CoreLightPurple.rawValue)
    static let corePurple = namedColor(ColorEnum.CorePurple.rawValue)
}
