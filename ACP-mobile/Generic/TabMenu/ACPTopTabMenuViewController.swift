//
//  ACPTopTabMenuViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

protocol ACPTopTabMenuViewControllerDelegate: AnyObject {
    var allTabsAreActive: Bool { get }

    func titleForTab(at index: ACPTopTabMenuViewController.TabIndex) -> String
    func viewControllerForTab(at index: ACPTopTabMenuViewController.TabIndex) -> UIViewController
    func selectedTabItem(at index: ACPTopTabMenuViewController.TabIndex)
}

class ACPTopTabMenuViewController: UIViewController {

    // MARK: - TabIndex

    enum TabIndex: Int {
        case first = 0
        case second = 1
        case third = 2

        var nextTab: TabIndex {
            switch self {
            case .first:
                return .second
            default:
                return .third
            }
        }

        var previousTab: TabIndex {
            switch self {
            case .third:
                return .second
            default:
                return .first
            }
        }
    }

	// MARK: - Properties

    private var childVC: UIViewController?

    private var currentTabItem = TabIndex.first

    weak var delegate: ACPTopTabMenuViewControllerDelegate? {
        didSet {
            setupTabItems()
        }
    }

    // MARK: - Views

    private let headerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray06Light
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Constants.Constraints.HeaderCornerRadius
        return view
    }()

    private let firstTabButton = ACPTopTabMenuButton()

    private let secondTabButton = ACPTopTabMenuButton()

    private let thirdTabButton = ACPTopTabMenuButton()

    private let childContainerView = UIView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()

        setupTabButtonCallbacks()
    }

    private func addSubviews() {
        view.addSubview(headerContainerView)
        headerContainerView.addSubview(firstTabButton)
        headerContainerView.addSubview(secondTabButton)
        headerContainerView.addSubview(thirdTabButton)
        view.addSubview(childContainerView)
    }

    private func setupConstraints() {
        headerContainerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.HeaderInsetHorizontal)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.HeaderInsetVertical)
            make.height.equalTo(Constants.Constraints.HeaderHeight)
        }

        firstTabButton.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(Constants.Constraints.TabButtonInset)
            make.right.equalTo(secondTabButton.snp.left)
            make.width.equalTo(secondTabButton)
        }

        secondTabButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.Constraints.TabButtonInset)
            make.left.equalTo(firstTabButton.snp.right)
            make.right.equalTo(thirdTabButton.snp.left)
            make.centerX.equalToSuperview()
        }

        thirdTabButton.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview().inset(Constants.Constraints.TabButtonInset)
            make.left.equalTo(secondTabButton.snp.right)
            make.width.equalTo(secondTabButton)
        }

        childContainerView.snp.makeConstraints { make in
            make.top.equalTo(headerContainerView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }

    // MARK: - Child View Controller

    private func add(asChildViewController viewController: UIViewController) {
        if let controllerToRemove = childVC {
            remove(asChildViewController: controllerToRemove)
        }

        childVC = viewController

        addChild(viewController)
        childContainerView.addSubview(viewController.view)

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

    // MARK: - Tab Items

    func setupTabItems() {
        firstTabButton.setText(text: delegate?.titleForTab(at: .first))
        secondTabButton.setText(text: delegate?.titleForTab(at: .second))
        thirdTabButton.setText(text: delegate?.titleForTab(at: .third))

        selectTabItem(tabIndex: .first)
    }

    func selectTabItem(tabIndex: TabIndex) {
        guard let delegate = delegate else {
            return
        }

        let statusForOtherButtons: TabButtonStatus = delegate.allTabsAreActive ? .active : .inactive

        currentTabItem = tabIndex

        switch tabIndex {
        case .first:
            firstTabButton.status = .selected
            secondTabButton.status = statusForOtherButtons
            thirdTabButton.status = statusForOtherButtons

        case .second:
            firstTabButton.status = .active
            secondTabButton.status = .selected
            thirdTabButton.status = statusForOtherButtons

        case .third:
            firstTabButton.status = .active
            secondTabButton.status = .active
            thirdTabButton.status = .selected
        }

        let controllerToAdd = delegate.viewControllerForTab(at: tabIndex)
        add(asChildViewController: controllerToAdd)

        delegate.selectedTabItem(at: tabIndex)
    }

    func nextTabItem() {
        selectTabItem(tabIndex: currentTabItem.nextTab)
    }

    func previousTabItem() {
        selectTabItem(tabIndex: currentTabItem.previousTab)
    }

    // MARK: - Tab Callback

    private func setupTabButtonCallbacks() {
        firstTabButton.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(didPressTabButton(_:))
        ))

        secondTabButton.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(didPressTabButton(_:))
        ))

        thirdTabButton.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(didPressTabButton(_:))
        ))
    }

    @objc func didPressTabButton(_ sender: UITapGestureRecognizer? = nil) {
        guard let tabButton = sender?.view as? ACPTopTabMenuButton else {
            return
        }

        guard tabButton.status != .inactive else {
            return
        }

        switch tabButton {
        case firstTabButton:
            selectTabItem(tabIndex: .first)

        case secondTabButton:
            selectTabItem(tabIndex: .second)

        default:
            selectTabItem(tabIndex: .third)
        }
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let HeaderInsetHorizontal: CGFloat = 35
            static let HeaderInsetVertical: CGFloat = 15
            static let HeaderCornerRadius: CGFloat = 10
            static let HeaderHeight: CGFloat = 40

            static let TabButtonInset: CGFloat = 4
        }
    }
}
