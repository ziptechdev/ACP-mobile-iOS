//
//  EligibilityServiceEndpoint.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import Alamofire

enum EligibilityServiceEndpoint {
    case eligibilityCheck(parameters: Parameters?)
    case register(id: String, parameters: Parameters?)
}

extension EligibilityServiceEndpoint: ACPEndpoint {
    var baseURL: String { "https://acp-mobile-backend.herokuapp.com/api/v1/" }

    var path: String {
        switch self {
        case .eligibilityCheck:
            return "national-verifier/eligibility-check"
        case .register(let id, _):
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

    var parameters: Parameters? {
        switch self {
        case .eligibilityCheck(let parameters):
            return parameters
        case .register(_, let parameters):
            return parameters
        }
    }
}
