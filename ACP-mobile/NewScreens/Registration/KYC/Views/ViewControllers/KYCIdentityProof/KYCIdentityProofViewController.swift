//
//  KYCIdentityProofViewController.swift
//  ACP-mobile
//
//  Created by Adi on 19/10/2022.
//

import UIKit
import SnapKit

class KYCIdentityProofViewController: UIViewController {

    // MARK: - Properties

    weak var delegate: TabMenuDelegate?

    // MARK: - Views

    private let tabMenu = TabMenuViewController(allowSelection: false)

    private let infoLabel = TermsAndPrivacyLabel()

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

// MARK: - TermsAndPrivacyLabelDelegate

extension KYCIdentityProofViewController: TermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        // TODO: Add link
    }

    func didTapPrivacy() {
        // TODO: Add link
    }
}

// MARK: - TabMenuDelegate

extension KYCIdentityProofViewController: TabMenuDelegate {
    func didTapNextButton() {
        // TODO: Add link
        print("afdf q22")
//        tabMenu.nextTab()
        tabMenu.openCamera()
    }

    func didTapActionButton() {
        // TODO: Add link
        print("afdf")
        delegate?.didTapNextButton()
    }
    
}

// MARK: - TabMenuViewControllerDelegate

extension KYCIdentityProofViewController: TabMenuViewControllerDelegate {
    var numberOfItems: Int {
        return 4
    }

    func setupViews(collectionView: UICollectionView, containerView: UIView) {
        collectionView.register(TabMenuDotCell.self)

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
        let cell: TabMenuDotCell = collectionView.dequeue(at: indexPath)
        return cell
    }

    func didSelectTab(index: Int) -> UIViewController {
        switch index {
        case 0:
            let viewController = KYCVerificationViewController()
            viewController.delegate = self
            return viewController
        case 1:
            let viewController = KYCScanIDViewController()
            viewController.delegate = self
            return viewController
        case 2:
            let viewController = KYCSelfieViewController()
            viewController.delegate = self
            return viewController
        default:
            let viewController = KYCCheckCompleteViewController()
            viewController.delegate = self
            return viewController
        }
    }
}
