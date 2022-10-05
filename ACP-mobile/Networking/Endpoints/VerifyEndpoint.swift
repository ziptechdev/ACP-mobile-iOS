//
//  VerifyEndpoint.swift
//  ACP-mobile
//
//  Created by Adi on 05/10/2022.
//

import Alamofire

enum VerifyEndpoint {
    case verify(parameters: Parameters?)
}

extension VerifyEndpoint: ACPEndpoint {
    var baseURL: String {
        return "https://api.universalservice.org/verify"
    }

    var path: String {
        switch self {
        case .verify:
            return ""
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .verify:
            return .get
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }

    var parameters: Parameters? {
        switch self {
        case .verify(let parameters):
            return parameters
        }
    }
}
