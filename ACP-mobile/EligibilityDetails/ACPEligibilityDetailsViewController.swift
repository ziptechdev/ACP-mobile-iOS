//
//  ACPEligibilityDetailsViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

protocol ACPEligibilityDetailsDelegate: AnyObject {
    func didTapNextButton(newIndex: Int)
    func didTapVerifyButton()
}

class ACPEligibilityDetailsViewController: UIViewController {

	// MARK: - Properties

    // MARK: - Views

    private let tabMenu = ACPTopTabMenuViewController()

    private let infoLabel = ACPTermsAndPrivacyLabel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        title = Constants.Text.Title
        navigationController?.navigationBar.isHidden = false

        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()
        setupTabMenu()

        infoLabel.delegate = self
    }

    private func addSubviews() {
        view.addSubview(infoLabel)
    }

    private func setupConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.HeaderInsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.HeaderInsetVertical)
        }
    }

    private func setupTabMenu() {
        // TODO: Make it into the model or a protocol
        tabMenu.setupTabItems([
            .init(title: "Name", viewController: ACPEligibilityDetailsNameViewController(self)),
            .init(title: "Date of Birth", viewController: ACPEligibilityDetailsDOBViewController(self)),
            .init(title: "Address", viewController: ACPEligibilityDetailsAddressViewController(self))
        ])

        addChild(tabMenu)
        view.addSubview(tabMenu.view)

        tabMenu.view.translatesAutoresizingMaskIntoConstraints = false
        tabMenu.view.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(infoLabel.snp.top)
        }

        tabMenu.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabMenu.didMove(toParent: self)
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

extension ACPEligibilityDetailsViewController: ACPTermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        // TODO: Add link
    }

    func didTapPrivacy() {
        // TODO: Add link
    }
}

extension ACPEligibilityDetailsViewController: ACPEligibilityDetailsDelegate {
    func didTapNextButton(newIndex: Int) {
        tabMenu.selectTabItem(index: newIndex)
    }

    func didTapVerifyButton() {
        print("Done")
    }
}
