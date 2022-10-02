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

        navigationBar.barTintColor = .white
        navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .regular),
            .foregroundColor: UIColor.gray06Dark
        ]
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        guard let callback = backButtonOverride else {
            return super.popViewController(animated: animated)
        }

        callback()
        backButtonOverride = nil

        return nil
    }

    /// Use this to ignore the back button override
    func pop(animated: Bool = true) {
        backButtonOverride = nil

        super.popViewController(animated: animated)
    }
}
