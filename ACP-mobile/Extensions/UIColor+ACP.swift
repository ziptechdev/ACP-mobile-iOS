//
//  UIColor+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 28/09/2022.
//

import UIKit

enum ACPColorEnum: String {
    case CoreBlue, Gray01Dark, Gray01Light, Gray03Light, Gray06Dark, Gray06Light, ACPYellow,
         WarningRed
}

extension UIColor {
    static let coreBlue = UIColor(named: ACPColorEnum.CoreBlue.rawValue)
    static let gray01Dark = UIColor(named: ACPColorEnum.Gray01Dark.rawValue)
    static let gray01Light = UIColor(named: ACPColorEnum.Gray01Light.rawValue)
    static let gray03Light = UIColor(named: ACPColorEnum.Gray03Light.rawValue)
    static let gray06Dark = UIColor(named: ACPColorEnum.Gray06Dark.rawValue)
    static let gray06Light = UIColor(named: ACPColorEnum.Gray06Light.rawValue)
    static let acpYellow = UIColor(named: ACPColorEnum.ACPYellow.rawValue)
    static let warningRed = UIColor(named: ACPColorEnum.WarningRed.rawValue)
}
