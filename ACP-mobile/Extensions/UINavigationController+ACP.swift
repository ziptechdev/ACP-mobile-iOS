//
//  UINavigationController+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 26/10/2022.
//
import UIKit

extension UINavigationController {
    func popInTheBackgroundToVC<T: UIViewController>(_ type: T.Type) {
        guard let targetIndex = viewControllers.firstIndex(where: { $0.isKind(of: type) }) else {
            fatalError("The ViewController of type \(type.description()) is not in the view stack")
        }

        var newStack = Array(viewControllers.prefix(targetIndex + 1))

        guard let lastVC = viewControllers.last else {
            fatalError("There are no ViewControllers in the view stack")
        }

        newStack.append(lastVC)

        setViewControllers(newStack, animated: false)
    }

    func popToRootInTheBackground() {
        guard let lastVC = viewControllers.last else {
            fatalError("There are no ViewControllers in the view stack")
        }

        setViewControllers([lastVC], animated: false)
    }
}
