//
//  EligibilityDetailsViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

class EligibilityDetailsViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: EligibilityDetailsViewModel

    // MARK: - Views

    private let tabMenu = TabMenuViewController()

    private let infoLabel = TermsAndPrivacyLabel()

    // MARK: - Initialization

    init(viewModel: EligibilityDetailsViewModel) {
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

        title = .localizedString(key: "eligibility_page_title")
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
            make.left.right.equalToSuperview().inset(Constants.HeaderInsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.HeaderInsetVertical)
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
        static let HeaderInsetHorizontal: CGFloat = 35
        static let HeaderInsetVertical: CGFloat = 20
        static let HeaderCornerRadius: CGFloat = 10
        static let HeaderHeight: CGFloat = 40
    }
}

// MARK: - TermsAndPrivacyLabelDelegate

extension EligibilityDetailsViewController: TermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        viewModel.openTerms()
    }

    func didTapPrivacy() {
        viewModel.openPrivacyPolicy()
    }
}

// MARK: - TabMenuDelegate

extension EligibilityDetailsViewController: TabMenuDelegate {
    func didTapNextButton() {
        tabMenu.nextTab()
    }

    func didTapActionButton() {
        viewModel.goToVerify()
    }
}

// MARK: - TabMenuViewControllerDelegate

extension EligibilityDetailsViewController: TabMenuViewControllerDelegate {
    var numberOfItems: Int {
        return viewModel.numberOfTabItems()
    }

    func setupViews(collectionView: UICollectionView, containerView: UIView) {
        collectionView.backgroundColor = .gray06Light
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = Constants.HeaderCornerRadius
        collectionView.contentInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)

        collectionView.register(TabMenuTitleCell.self)

        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.HeaderInsetHorizontal)
            make.top.equalToSuperview().inset(Constants.HeaderInsetVertical)
            make.height.equalTo(Constants.HeaderHeight)
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
            let viewController = EligibilityDetailsNameViewController(viewModel: viewModel)
            viewController.delegate = self
            return viewController
        case 1:
            let viewController = EligibilityDetailsDOBViewController(viewModel: viewModel)
            viewController.delegate = self
            return viewController
        default:
            let viewController = EligibilityDetailsAddressViewController(viewModel: viewModel)
            viewController.delegate = self
            return viewController
        }
    }
}
