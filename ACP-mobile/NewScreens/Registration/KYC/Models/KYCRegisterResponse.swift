//
//  KYCRegisterResponse.swift
//  ACP-mobile
//
//  Created by Adi on 28/12/2022.
//

struct KYCRegisterResponse: Codable {
    let statusCode: Int
    let message: String
    let data: KYCRegisterData?
}
