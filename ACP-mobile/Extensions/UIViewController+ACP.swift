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
    func setupRightNavigationBarButton() {
        let image = UIImage(named: "x_mark")?.withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(didTapRightButton)
        )

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
    func setupLeftNavigationBarButton() {
        let button = ACPImageButton(
            horizontal: 15,
            spacing: 7,
            cornerRadius: 0,
            imageName: "left_arrow",
            textColor: .gray01Light,
            isLeft: true
        )

        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)

        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: button)]
    }

    @objc func didTapLeftButton() {
        navigationController?.popViewController(animated: true)
    }
}
