//
//  EligibilityService.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

protocol EligibilityServiceProtocol {
    func eligibilityCheck(completion: @escaping RouterCompletion)
}

class EligibilityService: EligibilityServiceProtocol {

    private let router = ACPRouter.shared

    func eligibilityCheck(completion: @escaping RouterCompletion) {
        let endpoint = EligibilityServiceEndpoint.eligibilityCheck
        ACPRouter.shared.request(endpoint, completion: completion)
    }
}
