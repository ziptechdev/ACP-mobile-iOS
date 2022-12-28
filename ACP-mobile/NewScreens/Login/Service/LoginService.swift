//
//  LoginService.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

import Alamofire

class LoginService {
    func login(parameters: Parameters?, completion: @escaping RouterCompletion) {
        Router.shared.request(
            LoginServiceEndpoint.login(parameters: parameters),
            completion: completion
        )
    }
}
