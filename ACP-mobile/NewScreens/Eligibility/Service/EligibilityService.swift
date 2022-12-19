//
//  EligibilityService.swift
//  ACP-mobile
//
//  Created by Adi on 18/12/2022.
//

class EligibilityService {
    func eligibilityCheck(completion: @escaping RouterCompletion) {
        ACPRouter.shared.request(
            EligibilityServiceEndpoint.eligibilityCheck,
            completion: completion
        )
    }

    func registerUser(id: String, completion: @escaping RouterCompletion) {
        ACPRouter.shared.request(
            EligibilityServiceEndpoint.register(id: id),
            completion: completion
        )
    }
}
