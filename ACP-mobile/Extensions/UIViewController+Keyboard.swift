//
//  UIViewController+Keyboard.swift
//  ACP-mobile
//
//  Created by Adi on 07/10/2022.
//

import UIKit
import SnapKit

extension UIViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
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
    
    @objc func keyboardWillChangeFrame(_ notification: NSNotification) {
        let textFieldSpacing: CGFloat = 5

        guard let userInfo = notification.userInfo,
              let keyboardFrameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }

        // Keyboard information
        let keyboardFrame = keyboardFrameInfo.cgRectValue

        guard let activeTextField = UIResponder.currentFirst() as? UITextField,
              let textFieldSuperview = activeTextField.superview
        else {
            return
        }

        // Text Field information
        let positionInSuperview = textFieldSuperview.convert(activeTextField.frame.origin, to: view)
        let globalTextFieldPoint = view.convert(positionInSuperview, to: nil)
        let textFieldBottom = globalTextFieldPoint.y + activeTextField.frame.height
        let textFieldOffset = textFieldBottom - keyboardFrame.minY + textFieldSpacing

        if textFieldOffset > 0 {
            view.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().inset(textFieldOffset)
                make.top.equalToSuperview().offset(-textFieldOffset)
            }
        } else {
            view.snp.remakeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
        }
    }
}
