//
//  ACPEligibilityDetailsViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

protocol ACPEligibilityDetailsDelegate: AnyObject {
    func didTapNextButton()
    func didTapVerifyButton()
}

class ACPEligibilityDetailsViewController: UIViewController {

	// MARK: - Properties

    private let viewModel = ACPEligibilityDetailsViewModel()

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
        addChild(tabMenu)
        view.addSubview(tabMenu.view)

        tabMenu.view.translatesAutoresizingMaskIntoConstraints = false
        tabMenu.view.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(infoLabel.snp.top)
        }

        tabMenu.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabMenu.didMove(toParent: self)

        tabMenu.delegate = self
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

extension ACPEligibilityDetailsViewController: ACPTermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        // TODO: Add link
    }

    func didTapPrivacy() {
        // TODO: Add link
    }
}

// MARK: - ACPEligibilityDetailsDelegate

extension ACPEligibilityDetailsViewController: ACPEligibilityDetailsDelegate {
    func didTapNextButton() {
        tabMenu.nextTabItem()
    }

    func didTapVerifyButton() {
        viewModel.didTapVerify()

        let viewController = ACPEligibilityDetailsVerifyViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - ACPTopTabMenuViewControllerDelegate

extension ACPEligibilityDetailsViewController: ACPTopTabMenuViewControllerDelegate {
    var allTabsAreActive: Bool {
        return false
    }

    func titleForTab(at index: ACPTopTabMenuViewController.TabIndex) -> String {
        return viewModel.titleForTab(at: index)
    }

    func viewControllerForTab(at index: ACPTopTabMenuViewController.TabIndex) -> UIViewController {
        switch index {
        case .first:
            let viewController = ACPEligibilityDetailsNameViewController()
            viewController.delegate = self
            viewController.viewModel = viewModel
            return viewController
        case .second:
            let viewController = ACPEligibilityDetailsDOBViewController()
            viewController.delegate = self
            viewController.viewModel = viewModel
            return viewController
        case .third:
            let viewController = ACPEligibilityDetailsAddressViewController()
            viewController.delegate = self
            viewController.viewModel = viewModel
            return viewController
        }
    }

    func selectedTabItem(at index: ACPTopTabMenuViewController.TabIndex) {
        guard let navigationController = navigationController as? ACPNavigationController else {
            return
        }

        if index == .first {
            navigationController.backButtonOverride = nil
        } else {
            navigationController.backButtonOverride = tabMenu.previousTabItem
        }
    }
}
