//
//  UIResponder+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 07/10/2022.
//

import UIKit

extension UIResponder {
    static weak var responder: UIResponder?

    static func currentFirst() -> UIResponder? {
        responder = nil

        UIApplication.shared.sendAction(
            #selector(saveInfo),
            to: nil,
            from: nil,
            for: nil
        )

        return responder
    }

    @objc private func saveInfo() {
        UIResponder.responder = self
    }
}
