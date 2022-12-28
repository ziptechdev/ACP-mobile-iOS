//
//  FocusableView.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit

enum FocusStatus {
    case active
    case inactive
    case disabled
}

protocol FocusableView {
    func setStatus(status: FocusStatus)
    func onActive()
    func onInactive()
    func onDisable()
}

extension FocusableView where Self: UIView {
    func setStatus(status: FocusStatus) {
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
