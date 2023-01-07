//
//  Endpoint.swift
//  ACP-mobile
//
//  Created by Adi on 05/10/2022.
//

import Alamofire

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
}
