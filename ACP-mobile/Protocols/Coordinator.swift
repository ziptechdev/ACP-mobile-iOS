//
//  Coordinator.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    /// Called when the Coordinator is dismissed
    var onDismiss: (() -> Void)? { get set }
    /// Collection of child Coordinators
    var childCoordinators: [Coordinator] { get set }
    /// Navigation Controller used by the coordinator
    var navigationController: ACPNavigationController { get set }

    /// Start the Coordinator
    func start()
    /// Dismiss the Coordinator
    func dismiss()
    /// Add a child Coordinator
    func addChild(_ coordinator: Coordinator)
    /// Remove the child Coordinator
    func removeChild(_ coordinator: Coordinator)
}

/*
 Default implementation, you can override these by making the function in the coordinator.

 Be careful, as protocol conformance doesn't let you override the functions,
 instead if you need to change the implementation, implement the function to the Coordinator.

 Also as you can't override the function in the protocol - you cant't call super.functionName(),
 so the new function should contain the code from default implementation.
*/

extension Coordinator {
    func start() {}

    func dismiss() {
        onDismiss?()
    }

    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    func removeChild(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0 !== coordinator })
    }
}
