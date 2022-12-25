//
//  ACPTabMenuViewController.swift
//  ACP-mobile
//
//  Created by Adi on 05/10/2022.
//

import UIKit
import SnapKit

protocol ACPTabMenuDelegate: AnyObject {
    func didTapNextButton()
    func didTapActionButton()
}

protocol ACPTabMenuViewControllerDelegate: AnyObject {
    var numberOfItems: Int { get }

    func setupViews(collectionView: UICollectionView, containerView: UIView)
    func cellForIndex(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func didSelectTab(index: Int) -> UIViewController
}

class ACPTabMenuViewController: UIViewController {

    // MARK: - Properties

    private let allTabsEnabled: Bool
    private let allowSelection: Bool

    private var currentTabItem: Int

    private var childVC: UIViewController?

    weak var delegate: ACPTabMenuViewControllerDelegate? {
        didSet {
            didSetDelegate()
        }
    }

    public var currentTab: Int {
        return currentTabItem
    }

    // MARK: - Views

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.minimumInteritemSpacing = 0
        flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let view = UICollectionView(frame: .zero, collectionViewLayout: flow)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initialization

    init(initialTab: Int = 0, allTabsEnabled: Bool = false, allowSelection: Bool = true) {
        self.currentTabItem = initialTab
        self.allTabsEnabled = allTabsEnabled
        self.allowSelection = allowSelection

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

    // MARK: - UI

    private func setupUI() {
        addSubviews()
    }

    private func addSubviews() {
        view.addSubview(containerView)
        view.addSubview(collectionView)
    }

    // MARK: - Callback

    private func didSetDelegate() {
        delegate?.setupViews(collectionView: collectionView, containerView: containerView)

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.reloadData()

        selectTab(index: currentTabItem)
    }

    // MARK: - Child View Controller

    private func add(asChildViewController viewController: UIViewController) {
        if let controllerToRemove = childVC {
            remove(asChildViewController: controllerToRemove)
        }

        childVC = viewController

        addChild(viewController)
        containerView.addSubview(viewController.view)

        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }

        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    // MARK: - Selection

    private func selectTab(index: Int) {
        collectionView.selectItem(
            at: IndexPath(item: index, section: 0),
            animated: false,
            scrollPosition: .centeredHorizontally
        )
        collectionView(collectionView, didSelectItemAt: IndexPath(item: index, section: 0))
    }

    private func setupOtherCells(newIndex: IndexPath) {
        if allTabsEnabled {
            let previousIndexPath = IndexPath(item: currentTabItem, section: 0)
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? ACPFocusableView {
                previousCell.onInactive()
            }
        } else {
            guard let tabCount = delegate?.numberOfItems else {
                return
            }

            let indexesToSetup: [Int] = Array(0..<tabCount)
            indexesToSetup.forEach { index in
                let indexPath = IndexPath(item: index, section: 0)
                if let cell = collectionView.cellForItem(at: indexPath) as? ACPFocusableView {
                    if index < newIndex.item {
                        cell.onInactive()
                    } else {
                        cell.onDisable()
                    }
                }
            }
        }
    }

    // MARK: - Navigation

    func nextTab() {
        guard let numberOfItems = delegate?.numberOfItems else {
            return
        }

        if currentTabItem < numberOfItems {
            selectTab(index: currentTabItem + 1)
        }
    }

    func previousTab() {
        if currentTabItem > 0 {
            selectTab(index: currentTabItem - 1)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ACPTabMenuViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfItems ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = delegate?.cellForIndex(collectionView, indexPath: indexPath) else {
            return UICollectionViewCell()
        }

        if let focusableCell = cell as? ACPFocusableView {
            if indexPath.item == currentTabItem {
                focusableCell.onActive()
            } else if allTabsEnabled || (indexPath.item <= currentTabItem) {
                focusableCell.onInactive()
            } else {
                focusableCell.onDisable()
            }
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ACPTabMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setupOtherCells(newIndex: indexPath)

        if let cell = collectionView.cellForItem(at: indexPath) as? ACPFocusableView {
            cell.onActive()
        }

        currentTabItem = indexPath.item

        guard let viewController = delegate?.didSelectTab(index: currentTabItem) else {
            return
        }

        add(asChildViewController: viewController)
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if allowSelection {
            if allTabsEnabled {
                return true
            } else {
                return indexPath.item <= currentTabItem
            }
        } else {
            return false
        }
    }
}

extension ACPTabMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var contentWidthInset = collectionView.contentInset.left + collectionView.contentInset.right
        let numberOfItems = CGFloat(delegate?.numberOfItems ?? 0)
        // Add inter item spacing so the cells can be at maximum width
        contentWidthInset += numberOfItems
        let cellWidth = (collectionView.frame.width - contentWidthInset) / numberOfItems

        let contentHeightInset = collectionView.contentInset.top + collectionView.contentInset.bottom
        let cellHeight = collectionView.frame.height - contentHeightInset

        return CGSize(width: cellWidth, height: cellHeight)
    }
}
