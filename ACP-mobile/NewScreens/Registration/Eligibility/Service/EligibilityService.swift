//
//  EligibilityService.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

import Alamofire

class EligibilityService {
    func eligibilityCheck(parameters: Parameters?, completion: @escaping RouterCompletion) {
        Router.shared.request(
            EligibilityServiceEndpoint.eligibilityCheck(parameters: parameters),
            completion: completion
        )
    }

    func registerUser(id: String, parameters: Parameters?, completion: @escaping RouterCompletion) {
        Router.shared.request(
            EligibilityServiceEndpoint.register(id: id, parameters: parameters),
            completion: completion
        )
    }
}
