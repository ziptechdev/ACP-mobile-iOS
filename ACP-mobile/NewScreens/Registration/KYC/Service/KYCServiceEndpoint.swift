//
//  KYCServiceEndpoint.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import Alamofire

enum KYCServiceEndpoint {
    case verifyEmail(parameters: Parameters?)
    case kycRegister(parameters: Parameters?)
}

extension KYCServiceEndpoint: Endpoint {
    var baseURL: String { "https://acp-mobile-backend.herokuapp.com/api/v1/" }

    var path: String {
        switch self {
        case .verifyEmail:
            return "users/verify-email"
        case .kycRegister:
            return "users/kyc-register"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .verifyEmail,
                .kycRegister:
            return .post
        }
    }

    var headers: HTTPHeaders? { nil }

    var parameters: Parameters? {
        switch self {
        case .verifyEmail(let parameters),
                .kycRegister(let parameters):
            return parameters
        }
    }
}
