//
//  EgibilityZipViewController.swift
//  ACP-mobile
//
//  Created by Abi  on 4. 10. 2022..
//

import UIKit
import SnapKit

class EgibilityZipViewController: UIViewController {

    // MARK: - Views

    private let zipCodeView: EgibilityZipView = {
        let view = EgibilityZipView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties

    private let infoLabel = ACPTermsAndPrivacyLabel()

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        title = Constants.Text.Title
        navigationController?.navigationBar.isHidden = false

        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        infoLabel.delegate = self
        zipCodeView.delegate = self
        zipCodeView.zipSecondCodeTextField.delegate = self
        zipCodeView.zipFirstCodeTextField.delegate = self
    }
    
    // MARK: - UI

    func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setUpConstraints()
    }

    private func addSubviews() {
        view.addSubview(infoLabel)
        view.addSubview(zipCodeView)
    }

    private func setUpConstraints() {
        zipCodeView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(infoLabel.snp.top)
        }
        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.HeaderInsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.HeaderInsetVertical)
        }
    }

    @objc func focusZipCodeStack() {
        zipCodeView.zipCodeStackView.layer.borderColor = UIColor.coreBlue.cgColor
    }

    @objc func unfocusZipCodeStackView(firstCount: Int, secondCount: Int) {
        if firstCount == 0 && secondCount == 0 {
            zipCodeView.zipCodeStackView.layer.borderColor = UIColor.gray03Light.cgColor
            zipCodeView.errorLabel.isHidden = true
        }
    }

    @objc func checkIsZipCodeValid(firstCount: String, secondCount: String) {
        if firstCount.count == 5 && secondCount.count == 4 {
            zipCodeView.setVisibilityForValidZipCode()
        } else {
            zipCodeView.setVisibilityForInvalidZipCode()
        }
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let HeaderInsetHorizontal: CGFloat = 35
            static let HeaderInsetVertical: CGFloat = 5
            static let HeaderCornerRadius: CGFloat = 10
            static let HeaderHeight: CGFloat = 40
        }

        struct Text {
            static let Title = "Eligibility Check"
        }
    }
}

// MARK: - ACPTermsAndPrivacyLabelDelegate

extension EgibilityZipViewController: ACPTermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        // TODO: Add link
        print("Clicked on terms")
    }

    func didTapPrivacy() {
        // TODO: Add link
        print("Clicked on privacy")
    }
}

// MARK: - EgibilityCheckDelegate

extension EgibilityZipViewController: EgibilityZipCodeDelegate {
    func didPressDone(_ textfield: UITextField, _ secondTextfield: UITextField) {
        textfield.resignFirstResponder()
        secondTextfield.resignFirstResponder()
    }

    func didTapNextButton() {
        let targetVC = ACPEligibilityDetailsViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }
}

extension EgibilityZipViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == zipCodeView.zipFirstCodeTextField {
            zipCodeView.zipFirstCodeTextField.becomeFirstResponder()
        } else if textField == zipCodeView.zipSecondCodeTextField {
            zipCodeView.zipSecondCodeTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == zipCodeView.zipFirstCodeTextField || textField == zipCodeView.zipSecondCodeTextField {
            focusZipCodeStack()
        }
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = zipCodeView.zipFirstCodeTextField.text else { return false }
        guard let textSecond = zipCodeView.zipSecondCodeTextField.text else { return false }

        if textField == zipCodeView.zipFirstCodeTextField || textField == zipCodeView.zipSecondCodeTextField {
            unfocusZipCodeStackView(firstCount: text.count, secondCount: textSecond.count)
        }
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = zipCodeView.zipFirstCodeTextField.text else { return }
        guard let textSecond = zipCodeView.zipSecondCodeTextField.text else { return }

        if text.count == 5 {
            zipCodeView.zipSecondCodeTextField.becomeFirstResponder()
        }

        if textSecond.count == 4 {
            if text.count < 5 {
                zipCodeView.zipFirstCodeTextField.becomeFirstResponder()
            }
            zipCodeView.zipSecondCodeTextField.resignFirstResponder()
        }

        checkIsZipCodeValid(firstCount: text, secondCount: textSecond)
    }
}
