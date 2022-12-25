//
//  LoginServiceEndpoint.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import Alamofire

enum LoginServiceEndpoint {
    case login(parameters: Parameters?)
}

extension LoginServiceEndpoint: ACPEndpoint {
    var baseURL: String { "https://acp-mobile-backend.herokuapp.com/api/v1/" }

    var path: String {
        switch self {
        case .login:
            return "users/login"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var headers: HTTPHeaders? { nil }

    var parameters: Parameters? {
        switch self {
        case .login(let parameters):
            return parameters
        }
    }
}
