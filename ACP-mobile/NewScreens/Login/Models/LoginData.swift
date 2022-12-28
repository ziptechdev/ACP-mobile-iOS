//
//  LoginData.swift
//  ACP-mobile
//
//  Created by Adi on 25/12/2022.
//

struct LoginData: Codable {
    let id: Int
    let username: String
    let firstName: String
    let middleName: String
    let lastName: String
    let phoneNumber: String
    let token: String
}
