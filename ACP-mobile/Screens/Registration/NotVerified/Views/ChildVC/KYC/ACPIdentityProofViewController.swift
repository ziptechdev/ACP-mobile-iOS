//
//  ACPIdentityProofViewController.swift
//  ACP-mobile
//
//  Created by Adi on 19/10/2022.
//

import UIKit
import SnapKit

class ACPIdentityProofViewController: UIViewController {

	// MARK: - Properties

    weak var delegate: ACPTabMenuDelegate?

    // MARK: - Views

    private let tabMenu = ACPTabMenuViewController(allowSelection: false)

    private let infoLabel = ACPTermsAndPrivacyLabel()

    // MARK: - Initialization

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
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
            make.left.right.equalToSuperview().inset(Constants.Constraints.InfoLabelInsetX)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.InfoLabelInsetY)
        }
    }

    private func setupTabMenu() {
        addChild(tabMenu)
        view.addSubview(tabMenu.view)

        tabMenu.view.translatesAutoresizingMaskIntoConstraints = false
        tabMenu.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(infoLabel.snp.top)
        }

        tabMenu.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabMenu.didMove(toParent: self)

        tabMenu.delegate = self
    }

    // MARK: - Callbacks

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let HeaderInsetHorizontal: CGFloat = 140
            static let HeaderInsetVertical: CGFloat = 20
            static let HeaderHeight: CGFloat = 25

            static let InfoLabelInsetX: CGFloat = 35
            static let InfoLabelInsetY: CGFloat = 60
        }
    }
}

// MARK: - ACPTermsAndPrivacyLabelDelegate

extension ACPIdentityProofViewController: ACPTermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        // TODO: Add link
    }

    func didTapPrivacy() {
        // TODO: Add link
    }
}

// MARK: - ACPTabMenuDelegate

extension ACPIdentityProofViewController: ACPTabMenuDelegate {
    func didTapNextButton() {
        // TODO: Add link
        tabMenu.nextTab()
    }

    func didTapActionButton() {
        // TODO: Add link
        delegate?.didTapNextButton()
    }
}

// MARK: - ACPTabMenuViewControllerDelegate

extension ACPIdentityProofViewController: ACPTabMenuViewControllerDelegate {
    var numberOfItems: Int {
        return 4
    }

    func setupViews(collectionView: UICollectionView, containerView: UIView) {
        collectionView.register(ACPTabMenuDotCell.self)

        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.HeaderInsetHorizontal)
            make.bottom.equalToSuperview().inset(Constants.Constraints.HeaderInsetVertical)
            make.height.equalTo(Constants.Constraints.HeaderHeight)
        }

        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView.snp.top)
            make.top.left.right.equalToSuperview()
        }
    }

    func cellForIndex(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ACPTabMenuDotCell = collectionView.dequeue(at: indexPath)
        return cell
    }

    func didSelectTab(index: Int) -> UIViewController {
        switch index {
        case 0:
            let viewController = ACPKYCViewController()
            viewController.delegate = self
            return viewController
        case 1:
            let viewController = ACPScanIDViewController()
            viewController.delegate = self
            return viewController
        case 2:
            let viewController = ACPSelfieViewController()
            viewController.delegate = self
            return viewController
        default:
            let viewController = ACPKYCCompleteViewController()
            viewController.delegate = self
            return viewController
        }
    }
}
