//
//  EligibilityServiceEndpoint.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import Alamofire

enum EligibilityServiceEndpoint {
    case eligibilityCheck
    case register(id: String)
}

extension EligibilityServiceEndpoint: ACPEndpoint {
    var baseURL: String { "https://acp-mobile-backend.herokuapp.com/api/v1/" }

    var path: String {
        switch self {
        case .eligibilityCheck:
            return "national-verifier/eligibility-check"
        case .register(let id):
            return "users/eligibility-register/\(id)"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .eligibilityCheck,
                .register:
            return .post
        }
    }

    var headers: HTTPHeaders? { nil }

    var parameters: Parameters? { nil }
}
