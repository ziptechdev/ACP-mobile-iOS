//
//  LoginService.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

class LoginService {
    func login(completion: @escaping RouterCompletion) {
        ACPRouter.shared.request(
            LoginServiceEndpoint.login,
            completion: completion
        )
    }
}
