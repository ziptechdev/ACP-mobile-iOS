//
//  ACPNavigationController.swift
//  ACP-mobile
//
//  Created by Adi on 28/09/2022.
//

import UIKit

class ACPNavigationController: UINavigationController {

    /// Set this to override default back button behaviour
    var backButtonOverride: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.backgroundColor = .clear
        navigationBar.barTintColor = .white

        // Removes the line beneath the tab controller
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true

        navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .regular),
            .foregroundColor: UIColor.gray06Dark
        ]
    }

    func backButtonAction(animated: Bool = true) {
        guard let callback = backButtonOverride else {
            super.popViewController(animated: animated)
            return
        }

        callback()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        backButtonOverride = nil

        super.pushViewController(viewController, animated: animated)
    }

    @discardableResult
    override func popViewController(animated: Bool) -> UIViewController? {
        backButtonOverride = nil

        return super.popViewController(animated: animated)
    }
}
