//
//  ACPRouter.swift
//  ACP-mobile
//
//  Created by Adi on 05/10/2022.
//

import Alamofire

typealias RouterCompletion = (Data?, Error?) -> Void

class ACPRouter {

    // MARK: - Properties

    static let shared = ACPRouter()

    private var httpHeaders: HTTPHeaders {
        return [
            .accept("application/json"),
            .contentType("application/json")
        ]
    }

    private var encoding: ParameterEncoding { JSONEncoding.default }

    // MARK: - Request

    func request(_ endpoint: ACPEndpoint, completion: @escaping RouterCompletion) {
        let url = endpoint.baseURL + endpoint.path
        var httpHeaders = self.httpHeaders

        if let extraHeaders = endpoint.headers {
            extraHeaders.forEach({ httpHeaders.add($0) })
        }

        let request = AF.request(
            url,
            method: endpoint.httpMethod,
            parameters: endpoint.parameters,
            encoding: encoding,
            headers: httpHeaders
        )

        request.validate().responseData { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
