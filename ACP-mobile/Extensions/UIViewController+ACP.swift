//
//  UIViewController+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 02/10/2022.
//

import UIKit

extension UIViewController {

    // MARK: - Right Navigation Button

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

    func setupNotificationsBarButton() {
        let button = UIBarButtonItem(
            image: UIImage(named: "bell")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: nil
        )

        let spacer = UIBarButtonItem(
            barButtonSystemItem: .fixedSpace,
            target: nil,
            action: nil
        )
        spacer.width = 15

        navigationItem.rightBarButtonItems = [spacer, button]
    }

    // MARK: - Left Navigation Button

    func setupLeftNavigationBarButton(color: UIColor = .gray01Light) {
        let button = ImageButton(
            titleKey: "back_button",
            font: .systemFont(ofSize: 16, weight: .medium),
            horizontal: 15,
            spacing: 7,
            cornerRadius: 0,
            imageName: "left_arrow",
            textColor: color,
            isLeft: true
        )

        button.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: button)]
    }

    @objc func didTapLeftButton() {
        guard let navigationController = navigationController as? NavigationController else {
            return
        }

        navigationController.backButtonAction()
    }

    func setupHamburgerBarButton() {
        let button = UIBarButtonItem(
            image: UIImage(named: "hamburger")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: nil
        )

        let spacer = UIBarButtonItem(
            barButtonSystemItem: .fixedSpace,
            target: nil,
            action: nil
        )
        spacer.width = 15

        navigationItem.leftBarButtonItems = [spacer, button]
    }
    
    // hide keyboard when tap around
    func hideKeyboardWhenTappedAround() {
          let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
      }
      
    @objc func dismissKeyboard() {
          view.endEditing(true)
      }
    
}
