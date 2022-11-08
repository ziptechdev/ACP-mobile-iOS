//
//  ACPWalletViewController.swift
//  ACP-mobile
//
//  Created by Adi on 25/10/2022.
//

import UIKit
import SnapKit

class ACPWalletViewController: UIViewController {

    // MARK: - Properties

    // MARK: - Views

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    let debitCard = ACPDebitCardView()

    private lazy var newCardButton: ACPImageButton = {
        let button = ACPImageButton(
            titleKey: "wallet_btn",
            spacing: Constants.ButtonContentSpacing,
            cornerRadius: Constants.ButtonCornerRadius,
            imageName: "plus",
            isLeft: true
        )
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private let transactionsLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "wallet_transactions")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let tabMenu = ACPTabMenuViewController(allTabsEnabled: true)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        let test = ACPCardModel(
            balance: 64.77,
            cardNumber: "•••• •••• •••• 4215",
            expirationMonth: 4,
            expirationYear: 23,
            type: .debit,
            issuerLogo: "visa"
        )

        debitCard.setupCard(card: test)
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
        setupTabMenu()
    }

    private func addSubviews() {
        contentView.addSubview(debitCard)
        contentView.addSubview(newCardButton)
        contentView.addSubview(transactionsLabel)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.width.centerX.top.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.width.equalToSuperview()
        }

        debitCard.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.ContentInset)
            make.height.equalTo(Constants.CardHeight)
            make.top.equalToSuperview().inset(Constants.CardOffset)
        }

        newCardButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.ContentInset)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(debitCard.snp.bottom).offset(Constants.ButtonOffset)
        }

        transactionsLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.ContentInset)
            make.top.equalTo(newCardButton.snp.bottom).offset(Constants.TitleOffset)
        }
    }

    private func setupTabMenu() {
        addChild(tabMenu)
        contentView.addSubview(tabMenu.view)

        tabMenu.view.translatesAutoresizingMaskIntoConstraints = false
        tabMenu.view.snp.makeConstraints { make in
            make.top.equalTo(transactionsLabel.snp.bottom).offset(Constants.TabMenuOffset)
            make.left.right.bottom.equalToSuperview()
        }

        tabMenu.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabMenu.didMove(toParent: self)

        tabMenu.delegate = self
    }

    // MARK: - Callbacks

    @objc func didTapButton() {
        // TODO: Add action
    }

    // MARK: - Constants

    private struct Constants {
        static let ContentInset: CGFloat = 35

        static let CardOffset: CGFloat = 40
        static let CardHeight: CGFloat = 180

        static let ButtonContentSpacing: CGFloat = 10
        static let ButtonCornerRadius: CGFloat = 10
        static let ButtonHeight: CGFloat = 46
        static let ButtonOffset: CGFloat = 30

        static let TitleOffset: CGFloat = 60

        static let TabMenuHeight: CGFloat = 40
        static let TabMenuOffset: CGFloat = 30
        static let HeaderCornerRadius: CGFloat = 10
    }
}

extension ACPWalletViewController: ACPTabMenuViewControllerDelegate {
    var numberOfItems: Int {
        return 3
    }

    func setupViews(collectionView: UICollectionView, containerView: UIView) {
        collectionView.backgroundColor = .gray06Light
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = Constants.HeaderCornerRadius
        collectionView.contentInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)

        collectionView.register(ACPTabMenuTitleCell.self)

        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInset)
            make.top.equalToSuperview()
            make.height.equalTo(Constants.TabMenuHeight)
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

    func cellForIndex(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ACPTabMenuTitleCell = collectionView.dequeue(at: indexPath)
        let cellTitle: String = .localizedString(key: "wallet_transactions_tab_\(indexPath.row)")
        cell.configureCell(text: cellTitle)
        return cell
    }

    func didSelectTab(index: Int) -> UIViewController {
        // TODO: Add Proper VC
        let viewController = ACPTransactionsViewController()
        return viewController
    }
}
