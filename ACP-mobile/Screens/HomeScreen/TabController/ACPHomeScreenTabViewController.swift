//
//  ACPHomeScreenTabViewController.swift
//  ACP-mobile
//
//  Created by Adi on 25/10/2022.
//

import UIKit
import SnapKit

class ACPHomeScreenTabViewController: UIViewController {

    // MARK: - Properties

    private let viewModel = ACPHomeScreenTabViewModel()

    // MARK: - Views

    private let tabMenu = ACPTabMenuViewController(allTabsEnabled: true)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = false

        setupHamburgerBarButton()
        setupNotificationsBarButton()
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

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let TabMenuHeight: CGFloat = 100
        }
    }
}

extension ACPHomeScreenTabViewController: ACPTabMenuViewControllerDelegate {
    var numberOfItems: Int {
        return viewModel.numberOfTabItems()
    }

    func setupViews(collectionView: UICollectionView, containerView: UIView) {
        collectionView.register(ACPTabMenuImageCell.self)

        containerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.top)
        }

        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(Constants.Constraints.TabMenuHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func cellForIndex(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ACPTabMenuImageCell = collectionView.dequeue(at: indexPath)
        cell.configureCell(
            title: viewModel.titleForTab(at: indexPath.item),
            imageName: viewModel.imageNameForTab(at: indexPath.item)
        )
        return cell
    }

    func didSelectTab(index: Int) -> UIViewController {
        viewModel.currentTab = index

        title = viewModel.titleForTab(at: index)

        switch index {
        case 0:
            let viewController = ACPHomeScreenViewController()
            return viewController
        case 1:
            let viewController = ACPEmptyWalletViewController()
            return viewController
        default:
            // TODO: Add Proper VC
            let viewController = UIViewController()
            viewController.view.backgroundColor = .white
            return viewController
        }
    }
}
