//
//  ACPPersonalInfoViewController.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit
import SnapKit

class ACPPersonalInfoViewController: UIViewController {

	// MARK: - Properties

    private let viewModel = ACPPersonalInfoViewModel()

    // MARK: - Views

    private let tabMenu = ACPTabMenuViewController()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = .localizedString(key: "not_verified_register_page_title")
        navigationController?.navigationBar.isHidden = false

        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        setupTabMenu()
    }

    private func setupTabMenu() {
        addChild(tabMenu)
        view.addSubview(tabMenu.view)

        tabMenu.view.translatesAutoresizingMaskIntoConstraints = false
        tabMenu.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }

        tabMenu.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabMenu.didMove(toParent: self)

        tabMenu.delegate = self
    }

    // MARK: - Callbacks

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let HeaderInsetHorizontal: CGFloat = 35
            static let HeaderInsetVertical: CGFloat = 20
            static let HeaderCornerRadius: CGFloat = 10
            static let HeaderHeight: CGFloat = 40
        }
    }
}

// MARK: - ACPTermsAndPrivacyLabelDelegate

extension ACPPersonalInfoViewController: ACPTermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        // TODO: Add link
    }

    func didTapPrivacy() {
        // TODO: Add link
    }
}

// MARK: - ACPTabMenuDelegate

extension ACPPersonalInfoViewController: ACPTabMenuDelegate {
    func didTapNextButton() {
        if tabMenu.currentTab == 0 {
            let verifyVC = ACPVerifyEmailViewController(dismissCallback: tabMenu.nextTab)
            navigationController?.present(verifyVC, animated: true)
        } else {
            tabMenu.nextTab()
        }
    }

    func didTapActionButton() {
        let targetVC = ACPRegistrationCompleteViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }
}

// MARK: - ACPTabMenuViewControllerDelegate

extension ACPPersonalInfoViewController: ACPTabMenuViewControllerDelegate {
    var numberOfItems: Int {
        return viewModel.numberOfTabItems()
    }

    func setupViews(collectionView: UICollectionView, containerView: UIView) {
        collectionView.backgroundColor = .gray06Light
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = Constants.Constraints.HeaderCornerRadius
        collectionView.contentInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)

        collectionView.register(ACPTabMenuTitleCell.self)

        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.HeaderInsetHorizontal)
            make.top.equalToSuperview().inset(Constants.Constraints.HeaderInsetVertical)
            make.height.equalTo(Constants.Constraints.HeaderHeight)
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }

    func cellForIndex(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ACPTabMenuTitleCell = collectionView.dequeue(at: indexPath)
        cell.configureCell(text: viewModel.titleForTab(at: indexPath.item))
        return cell
    }

    func didSelectTab(index: Int) -> UIViewController {
        switch index {
        case 0:
            let viewController = ACPPersonalInfoDetailsViewController()
            viewController.delegate = self
            return viewController
        case 1:
            let viewController = ACPIdentityProofViewController()
            viewController.delegate = self
            return viewController
        default:
            let viewController = ACPBankInfoViewController()
            viewController.delegate = self
            return viewController
        }
    }
}