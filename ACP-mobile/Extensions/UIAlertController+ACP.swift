//
//  UIAlertController+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 17/12/2022.
//

import UIKit

extension UIAlertController {

    convenience init(title: String?, message: String?, actionSheet: Bool = false) {
        self.init(title: title, message: message, preferredStyle: actionSheet ? .actionSheet : .alert)
    }

    class func alertController(
        title: String? = nil,
        message: String? = nil,
        actionSheet: Bool = false
    ) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: (actionSheet) ? .actionSheet : .alert)
    }

    func addAction(_ title: String, withHandler handler: (() -> Void)? = nil) {
        addActionWithTitle(title: title, style: .default, handler: handler)
    }

    func setActionColour(color: UIColor, title: String) {
        actions.first(where: { $0.title == title })?.setValue(color, forKey: "titleTextColor")
    }

    func addDestructiveAction(_ title: String, withHandler handler: (() -> Void)? = nil) {
        addActionWithTitle(title: title, style: .destructive, handler: handler)
    }

    func addCancelAction(_ title: String? = nil, handler: (() -> Void)? = nil) {
        let cancelTitle = title == nil ? "Cancel" : title!
        addActionWithTitle(title: cancelTitle, style: .cancel, handler: handler)
    }

    private func addActionWithTitle(
        title: String,
        style: UIAlertAction.Style = .default,
        handler: (() -> Void)? = nil
    ) {
        addAction(UIAlertAction(title: title, style: style) { _ in
            handler?()
        })
    }

    class func showAlert(
        title: String? = nil,
        message: String? = nil,
        from: UIViewController,
        completion: (() -> Void)? = nil
    ) {
        let theAlert = UIAlertController.alertController(title: title, message: message)
        theAlert.addCancelAction("OK", handler: completion)
        theAlert.presentFrom(from)
    }

    class func showErrorAlert(_ error: Error, from: UIViewController, completion: (() -> Void)? = nil) {
        showErrorAlert(message: error.localizedDescription, from: from, completion: completion)
    }

    class func showErrorAlert(message: String? = nil, from: UIViewController, completion: (() -> Void)? = nil) {
        let theAlert = alertController(title: "Error", message: message)
        theAlert.addActionWithTitle(title: "OK", handler: completion)
        theAlert.presentFrom(from)
     }

    func presentFrom(_ from: UIViewController) {
        view.tintColor = from.view.tintColor
        from.present(self, animated: true)
    }
}
