//
//  UIViewController+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 02/10/2022.
//

import UIKit

extension UIViewController {

    // MARK: - Right Navigation Button

    /// Adds an X button to the left side
    func setupRightNavigationBarButton(color: UIColor? = nil) {
        let image: UIImage?
        if color != nil {
            image = UIImage(named: "x_mark")?.withRenderingMode(.alwaysTemplate)
        } else {
            image = UIImage(named: "x_mark")?.withRenderingMode(.alwaysOriginal)
        }

        let button = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(didTapRightButton)
        )

        if let color = color {
            button.tintColor = color
        }

        let spacer = UIBarButtonItem(
            barButtonSystemItem: .fixedSpace,
            target: nil,
            action: nil
        )
        spacer.width = 15

        navigationItem.rightBarButtonItems = [spacer, button]
    }

    @objc func didTapRightButton() {
        navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Left Navigation Button

    /// Adds a back button with an arrow to the right side
    func setupLeftNavigationBarButton(color: UIColor = .gray01Light) {
        let button = ACPImageButton(
            horizontal: 15,
            spacing: 7,
            cornerRadius: 0,
            imageName: "left_arrow",
            textColor: color,
            isLeft: true
        )

        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)

        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: button)]
    }

    @objc func didTapLeftButton() {
        guard let navigationController = navigationController as? ACPNavigationController else {
            return
        }

        navigationController.backButtonAction()
    }
}
