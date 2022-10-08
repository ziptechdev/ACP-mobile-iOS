//
//  ACPKeyboardHelper.swift
//  ACP-mobile
//
//  Created by Adi on 07/10/2022.
//

import UIKit
import SnapKit

// MARK: - ACPKeyboardHelperDelegate

protocol ACPKeyboardHelperDelegate: AnyObject {
    func keyboardWillAppear(height: CGFloat)
    func keyboardWillDisappear()
}

extension ACPKeyboardHelperDelegate where Self: UIViewController {
    func keyboardWillAppear(height: CGFloat) {
        let keyboardTop = CGPoint(x: 0, y: height)
        let globalPoint = view.convert(keyboardTop, to: nil)
        let heightDifference = globalPoint.y - height
        let keyboardHeightInView = height - heightDifference

        view.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(keyboardHeightInView)
            make.top.equalToSuperview().offset(-keyboardHeightInView)
        }
    }

    func keyboardWillDisappear() {
        view.snp.remakeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - ACPKeyboardHelper

class ACPKeyboardHelper {

	// MARK: - Properties

    private var isKeyboardActive = false

    weak var delegate: ACPKeyboardHelperDelegate? {
        didSet {
            startObserving()
        }
    }

    // MARK: - Observers

    private func startObserving() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillAppear(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillDisappear(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: - Life Cycle

    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: - Callback

    @objc func keyboardWillAppear(_ notification: NSNotification) {
        guard !isKeyboardActive else {
            return
        }

        guard let userInfo = notification.userInfo else {
            return
        }

        guard let keyboardFrameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardFrame = keyboardFrameInfo.cgRectValue

        isKeyboardActive = true
        delegate?.keyboardWillAppear(height: keyboardFrame.height)
    }

    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        guard isKeyboardActive else {
            return
        }

        isKeyboardActive = false
        delegate?.keyboardWillDisappear()
    }
}
