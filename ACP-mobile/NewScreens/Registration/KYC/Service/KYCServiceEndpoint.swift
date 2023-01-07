//
//  KYCServiceEndpoint.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import Alamofire

enum KYCServiceEndpoint {
    case verifyEmail(parameters: Parameters?)
    case kycRegister(complexPath: String?, complexPathWorkflow: String?,parameters: Parameters?)
}

extension KYCServiceEndpoint: Endpoint {
    var baseURL: String { "https://acp-mobile-backend.herokuapp.com/api/v1/" }

    var path: String {
        switch self {
        case .verifyEmail:
            return "users/verify-email"
        case .kycRegister(let complexPath, let complexPathWorkflow, _):
            return "users/kyc-register/account-id/"+(complexPath ?? "")+"/workflow-execution-id/"+(complexPathWorkflow ?? "")
//            /users/kyc-register/account-id/{accountId}/workflow-execution-id/{workflowExecutionId}
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
        case .verifyEmail(let parameters):
            return parameters
        case .kycRegister(_, _, let parameters):
            return parameters
        }
    }
}
