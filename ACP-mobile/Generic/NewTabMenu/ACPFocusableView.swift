//
//  ACPFocusableView.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit

enum ACPFocusStatus {
    case active
    case inactive
    case disabled
}

protocol ACPFocusableView {
    func setStatus(status: ACPFocusStatus)
    func onActive()
    func onInactive()
    func onDisable()
}

extension ACPFocusableView where Self: UIView {
    func setStatus(status: ACPFocusStatus) {
        switch status {
        case .active:
            onActive()

        case .inactive:
            onInactive()

        case .disabled:
            onDisable()
        }
    }
}
