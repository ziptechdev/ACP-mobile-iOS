//
//  ACPTopTabMenuViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

class ACPTopTabMenuViewController: UIViewController {

	// MARK: - Properties

    private var childVC: UIViewController?
    private var tabMenuItems: [ACPTabMenuChildModel] = []

    // MARK: - Views

    private let headerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray06Light
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Constants.Constraints.HeaderCornerRadius
        return view
    }()

    private let firstTabButton = ACPTopTabMenuButton(status: .selected)

    private let secondTabButton = ACPTopTabMenuButton()

    private let thirdTabButton = ACPTopTabMenuButton()

    private let childContainerView = UIView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
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

    func setupTabItems(_ tabItems: [ACPTabMenuChildModel]) {
        tabMenuItems = tabItems

        firstTabButton.setText(text: tabItems[0].title)
        secondTabButton.setText(text: tabItems[1].title)
        thirdTabButton.setText(text: tabItems[2].title)

        selectTabItem(index: 0)
    }

    func selectTabItem(index: Int) {
        guard index < tabMenuItems.count else {
            return
        }

        let controllerToAdd = tabMenuItems[index].viewController
        add(asChildViewController: controllerToAdd)
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

            firstTabButton.status = .selected
            secondTabButton.status = .inactive
            thirdTabButton.status = .inactive

            selectTabItem(index: 0)

        case secondTabButton:
            firstTabButton.status = .active
            secondTabButton.status = .selected
            thirdTabButton.status = .inactive

            selectTabItem(index: 1)

        case thirdTabButton:
            firstTabButton.status = .active
            secondTabButton.status = .active
            thirdTabButton.status = .selected

            selectTabItem(index: 2)

        default:
            break
        }
    }

    // MARK: - Presenting

    func setTabTitles(first: String, second: String, third: String) {
        firstTabButton.setText(text: first)
        secondTabButton.setText(text: second)
        thirdTabButton.setText(text: third)
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
