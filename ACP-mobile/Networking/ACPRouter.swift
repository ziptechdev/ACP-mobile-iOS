//
//  ACPRouter.swift
//  ACP-mobile
//
//  Created by Adi on 05/10/2022.
//

import Alamofire

protocol ACPRouterDelegate: AnyObject {
    func receivedResponse(_ response: Data)
    func receivedError(_ error: Error)
}

class ACPRouter {

	// MARK: - Properties

    private var httpHeaders: HTTPHeaders = [
        .contentType("application/json")
    ]

    private let encoding: ParameterEncoding = JSONEncoding.default

    weak var delegate: ACPRouterDelegate?

    // MARK: - Request

    func request(_ endpoint: ACPEndpoint) {
        let url = endpoint.baseURL + endpoint.path

        if let extraHeaders = endpoint.headers {
            extraHeaders.forEach({ httpHeaders.add($0) })
        }

        let authStr = "Username:Password"
        let authData = authStr.data(using: .utf8)

        // TODO: Real Auth
        httpHeaders.add(.authorization("Basic \(authData!.base64EncodedString(options: []))"))

        let request = AF.request(
            url,
            method: endpoint.httpMethod,
            parameters: endpoint.parameters,
            encoding: encoding,
            headers: httpHeaders
        )

        request.validate().responseData { [weak self] response in
            guard let self = self else {
                return
            }

            switch response.result {
            case .success(let value):
                self.delegate?.receivedResponse(value)
            case .failure(let error):
                self.delegate?.receivedError(error)
            }
        }
    }
}
