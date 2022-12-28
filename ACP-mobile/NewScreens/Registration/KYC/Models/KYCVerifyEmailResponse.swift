//
//  KYCVerifyEmailResponse.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

struct KYCVerifyEmailResponse: Codable {
    let statusCode: Int
    let message: String
    let data: KYCVerifyEmailData?
}
