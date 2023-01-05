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

struct KYCScanDocumentResponse: Codable {
    let statusCode: Int
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let timestamp: String
    let account, workflowExecution: Account
}

// MARK: - Account
struct Account: Codable {
    let id: String
}
