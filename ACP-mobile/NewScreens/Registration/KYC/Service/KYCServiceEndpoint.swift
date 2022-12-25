//
//  KYCServiceEndpoint.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import Alamofire

enum KYCServiceEndpoint {
    case kyc
}

extension KYCServiceEndpoint: Endpoint {
    var baseURL: String { "https://acp-mobile-backend.herokuapp.com/api/v1/" }

    var path: String {
        switch self {
        case .kyc:
            return "kyc"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .kyc:
            return .post
        }
    }

    var headers: HTTPHeaders? { nil }

    var parameters: Parameters? { nil }
}
