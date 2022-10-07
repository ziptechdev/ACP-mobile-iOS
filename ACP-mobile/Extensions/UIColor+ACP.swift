//
//  UIColor+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 28/09/2022.
//

import UIKit

enum ACPColorEnum: String {
    case CoreBlue, Gray01Dark, Gray01Light, Gray03Light, Gray06Dark, Gray06Light, ACPYellow,
         WarningRed, SuccessGreen, CoreLightBlue
}

extension UIColor {

    static func namedColor(_ name: String) -> UIColor {
        return UIColor(named: name) ?? .black
    }

    static let coreBlue = namedColor(ACPColorEnum.CoreBlue.rawValue)
    static let gray01Dark = namedColor(ACPColorEnum.Gray01Dark.rawValue)
    static let gray01Light = namedColor(ACPColorEnum.Gray01Light.rawValue)
    static let gray03Light = namedColor(ACPColorEnum.Gray03Light.rawValue)
    static let gray06Dark = namedColor(ACPColorEnum.Gray06Dark.rawValue)
    static let gray06Light = namedColor(ACPColorEnum.Gray06Light.rawValue)
    static let acpYellow = namedColor(ACPColorEnum.ACPYellow.rawValue)
    static let warningRed = namedColor(ACPColorEnum.WarningRed.rawValue)
    static let successGreen = namedColor(ACPColorEnum.SuccessGreen.rawValue)
    static let coreLightBlue = namedColor(ACPColorEnum.CoreLightBlue.rawValue)
}
