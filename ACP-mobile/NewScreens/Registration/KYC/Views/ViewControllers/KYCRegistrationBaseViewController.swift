//
//  KYCRegistrationBaseViewController.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit
import SnapKit

class KYCRegistrationBaseViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: KYCRegistrationViewModel

    // MARK: - Views

    private let tabMenu = TabMenuViewController()

    // MARK: - Initialization

    init(viewModel: KYCRegistrationViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

        viewModel.dismissVerifyEmail = { [weak self] in
            self?.tabMenu.nextTab()
            self?.navigationController?.dismiss(animated: true)
        }

        viewModel.showErrorMessage = { [weak self] message in
            guard let self = self else { return }
            UIAlertController.showErrorAlert(message: message, from: self)
        }
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

// MARK: - TabMenuDelegate

extension KYCRegistrationBaseViewController: TabMenuDelegate {
    func didTapNextButton() {
        if tabMenu.currentTab == 0 {
            viewModel.sendEmailCode()
        } else {
            tabMenu.nextTab()
        }
    }

    func didTapActionButton() {
        viewModel.register()
    }
}

// MARK: - TabMenuViewControllerDelegate

extension KYCRegistrationBaseViewController: TabMenuViewControllerDelegate {
    var numberOfItems: Int {
        return viewModel.numberOfTabItems()
    }

    func setupViews(collectionView: UICollectionView, containerView: UIView) {
        collectionView.backgroundColor = .gray06Light
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = Constants.Constraints.HeaderCornerRadius
        collectionView.contentInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)

        collectionView.register(TabMenuTitleCell.self)

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
        let cell: TabMenuTitleCell = collectionView.dequeue(at: indexPath)
        cell.configureCell(text: viewModel.titleForTab(at: indexPath.item))
        return cell
    }

    func didSelectTab(index: Int) -> UIViewController {
        switch index {
        case 0:
            let viewController = KYCPersonalInfoDetailsViewController(viewModel: viewModel)
            viewController.delegate = self
            return viewController
        case 1:
            let viewController = KYCIdentityProofViewController()
            viewController.delegate = self
            return viewController
        default:
            let viewController = KYCBankInfoViewController(viewModel: viewModel)
            viewController.delegate = self
            return viewController
        }
    }
}
