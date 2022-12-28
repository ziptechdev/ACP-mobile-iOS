//
//  KYCService.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import Alamofire

class KYCService {
    func verifyEmail(parameters: Parameters?, completion: @escaping RouterCompletion) {
        Router.shared.request(
            KYCServiceEndpoint.verifyEmail(parameters: parameters),
            completion: completion
        )
    }

    func kycRegister(parameters: Parameters?, completion: @escaping RouterCompletion) {
        Router.shared.request(
            KYCServiceEndpoint.kycRegister(parameters: parameters),
            completion: completion
        )
    }
}
