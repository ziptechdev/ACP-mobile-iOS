//
//  ACPDebitCardView.swift
//  ACP-mobile
//
//  Created by Adi on 25/10/2022.
//

import UIKit
import SnapKit

class ACPDebitCardView: UIView {

    // MARK: - Views

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let totalBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "wallet_balance")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        return label
    }()

    private let cardLogoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
    }()

    private let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()

    private let cardTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .coreLightPurple
        return label
    }()

    private let cardExpirationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .corePurple
        layer.cornerRadius = Constants.Constraints.CornerRadius
        layer.masksToBounds = true

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        addSubview(balanceLabel)
        addSubview(totalBalanceLabel)
        addSubview(cardLogoView)
        addSubview(cardNumberLabel)
        addSubview(cardTypeLabel)
        addSubview(cardExpirationLabel)
    }

    private func setupConstraints() {
        balanceLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
        }

        totalBalanceLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(Constants.Constraints.BalanceOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
        }

        cardLogoView.snp.makeConstraints { make in
            make.centerY.equalTo(balanceLabel)
            make.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.CardLogoHeight)
        }

        cardNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(totalBalanceLabel.snp.bottom).offset(Constants.Constraints.CardNumberOffset)
            make.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
        }

        cardTypeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.bottom.equalToSuperview().inset(Constants.Constraints.ContentInsetBottom)
        }

        cardExpirationLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.bottom.equalToSuperview().inset(Constants.Constraints.ContentInsetBottom)
        }
    }

    // MARK: - Card

    func setupCard(card: ACPCardModel) {
        setCardBalance(card.balance)
        setCardNumber(card.cardNumber)
        setCardIssuerImage(card.issuerLogo)
        setCardType(card.type)
        setCardExpiration(month: card.expirationMonth, year: card.expirationYear)
    }

    private func setCardBalance(_ balance: Float) {
        let cardBalance = String(format: "$%.2f", balance)
        balanceLabel.text = cardBalance
    }

    private func setCardNumber(_ number: String) {
        let cardNumber = NSMutableAttributedString(string: number)
        cardNumber.addAttribute(.kern, value: 4)
        cardNumberLabel.attributedText = cardNumber
    }

    private func setCardIssuerImage(_ imageName: String) {
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        cardLogoView.image = image
    }

    private func setCardType(_ type: CardType) {
        let stringKey = "wallet_\(type.rawValue)_card"
        cardTypeLabel.text = .localizedString(key: stringKey)
    }

    private func setCardExpiration(month: Int, year: Int) {
        let cardExpiration = String(format: "%02d/%02d", month, year)
        cardExpirationLabel.text = cardExpiration
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let CornerRadius: CGFloat = 10

            static let ContentInset: CGFloat = 30
            static let ContentInsetBottom: CGFloat = 20

            static let BalanceOffset: CGFloat = 5
            static let CardNumberOffset: CGFloat = 10

            static let CardLogoHeight: CGFloat = 18
        }
    }
}
