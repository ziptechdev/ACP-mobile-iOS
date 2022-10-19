//
//  TestEndpoint.swift
//  ACP-mobile
//
//  Created by Adi on 05/10/2022.
//

import Alamofire

enum TestEndpoint {
    case pokemon(path: String, parameters: Parameters?)
    case ability(path: String, parameters: Parameters?)
}

extension TestEndpoint: ACPEndpoint {
    var baseURL: String {
        return "https://pokeapi.co/api/v2"
    }

    var path: String {
        switch self {
        case .pokemon(let path, _):
            return "/pokemon/\(path)"

        case .ability(let path, _):
            return "/ability/\(path)"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .pokemon:
            return .get
        case .ability:
            return .get
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }

    var parameters: Parameters? {
        switch self {
        case .pokemon(_, let parameters),
                .ability(_, let parameters):
            return parameters
        }
    }
}
