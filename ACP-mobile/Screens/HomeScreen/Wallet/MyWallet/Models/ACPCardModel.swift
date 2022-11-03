//
//  ACPCardModel.swift
//  ACP-mobile
//
//  Created by Adi on 29/10/2022.
//

import UIKit

enum CardType: String {
    case debit
    case credit
}

struct ACPCardModel {
    let balance: Float
    let cardNumber: String
    let expirationMonth: Int
    let expirationYear: Int
    let type: CardType
    let issuerLogo: String
}
