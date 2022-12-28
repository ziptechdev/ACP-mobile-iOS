//
//  KYCResponse.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

struct KYCResponse: Codable {
    let statusCode: Int
    let message: String
    let data: KYCData?
}
