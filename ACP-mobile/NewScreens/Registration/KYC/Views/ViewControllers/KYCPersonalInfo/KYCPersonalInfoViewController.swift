//
//  KYCPersonalInfoViewController.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit
import SnapKit

class KYCPersonalInfoViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: KYCPersonalInfoViewModel

    // MARK: - Views

    private let tabMenu = TabMenuViewController()

    // MARK: - Initialization

    init(viewModel: KYCPersonalInfoViewModel) {
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

        viewModel.nextTab = tabMenu.nextTab
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

extension KYCPersonalInfoViewController: TabMenuDelegate {
    func didTapNextButton() {
        if tabMenu.currentTab == 0 {
            viewModel.openVerifyEmail()

        } else {
            tabMenu.nextTab()
        }
    }

    func didTapActionButton() {
        let targetVC = ACPRegistrationCompleteViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }
}

// MARK: - TabMenuViewControllerDelegate

extension KYCPersonalInfoViewController: TabMenuViewControllerDelegate {
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
