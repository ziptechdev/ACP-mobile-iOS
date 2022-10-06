//
//  ACPEligibilityDetailsViewController.swift
//  ACP-mobile
//
//  Created by Adi on 01/10/2022.
//

import UIKit
import SnapKit

protocol ACPEligibilityDetailsDelegate: AnyObject {
    func didTapNextButton()
    func didTapVerifyButton()
}

class ACPEligibilityDetailsViewController: UIViewController {

	// MARK: - Properties

    private let viewModel = ACPEligibilityDetailsViewModel()

    // MARK: - Views

    private let tabMenu = ACPTabMenuViewController()

    private let infoLabel = ACPTermsAndPrivacyLabel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = Constants.Text.Title
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
            make.left.right.equalToSuperview().inset(Constants.Constraints.HeaderInsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.HeaderInsetVertical)
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
            static let HeaderInsetHorizontal: CGFloat = 35
            static let HeaderInsetVertical: CGFloat = 20
            static let HeaderCornerRadius: CGFloat = 10
            static let HeaderHeight: CGFloat = 40
        }

        struct Text {
            static let Title = "Eligibility Check"
        }
    }
}

// MARK: - ACPTermsAndPrivacyLabelDelegate

extension ACPEligibilityDetailsViewController: ACPTermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        // TODO: Add link
    }

    func didTapPrivacy() {
        // TODO: Add link
    }
}

// MARK: - ACPEligibilityDetailsDelegate

extension ACPEligibilityDetailsViewController: ACPEligibilityDetailsDelegate {
    func didTapNextButton() {
        tabMenu.nextTab()
    }

    func didTapVerifyButton() {
        viewModel.didTapVerify()

        let viewController = ACPEligibilityDetailsVerifyViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - ACPTopTabMenuViewControllerDelegate

extension ACPEligibilityDetailsViewController: ACPTabMenuViewControllerDelegate {
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
            let viewController = ACPEligibilityDetailsNameViewController()
            viewController.delegate = self
            viewController.viewModel = viewModel
            return viewController
        case 1:
            let viewController = ACPEligibilityDetailsDOBViewController()
            viewController.delegate = self
            viewController.viewModel = viewModel
            return viewController
        default:
            let viewController = ACPEligibilityDetailsAddressViewController()
            viewController.delegate = self
            viewController.viewModel = viewModel
            return viewController
        }
    }
}

class TestCell: UICollectionViewCell {
    let a = UIView()
    let b = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(a)
        a.translatesAutoresizingMaskIntoConstraints = false
        a.layer.cornerRadius = 6

        a.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }

        contentView.addSubview(b)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .black
        b.layer.cornerRadius = 5

        b.snp.makeConstraints { make in
            make.width.height.equalTo(10)
            make.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TestCell: ACPFocusableView {
    func onActive() {
        b.backgroundColor = .white
    }

    func onInactive() {
        b.backgroundColor = .black
    }

    func onDisable() {
        b.backgroundColor = .black
    }


}
