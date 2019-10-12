//
//  ApiManager.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import Foundation

// MARK: - ApiManager Constants

enum HttpMethod: String {
    case POST, GET, UPDATE, DELETE
}

struct ServiceResponse {
    var entireResponse: Data?
    var error: Error?
    var responseCode: Int?
}

typealias ServiceFailure = (ServiceResponse) -> (Void)
typealias ServiceSuccess = (ServiceResponse) -> (Void)


// MARK: - ApiManager Implementation

class ApiManager {
    static let shared: ApiManager = ApiManager()
    var session: URLSessionProtocol = URLSession.shared

    func serviceRequest(path: URL,
                        method: HttpMethod,
                        encodeData: Data?,
                        headers: [String: String]?,
                        success: @escaping ServiceSuccess,
                        failure: @escaping ServiceFailure) {

        var request = URLRequest(url: path,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: .init(60))

        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = encodeData

        let serviceTask = session.dataTask(with: request) { (data, urlResponse, error) in
            let   responseCode = (urlResponse as? HTTPURLResponse)?.statusCode

            let serviceResponse = ServiceResponse(entireResponse: data,
                                                  error: error,
                                                  responseCode: responseCode)
            switch (responseCode) {
            case (200 ..< 300)?:
                DispatchQueue.main.async {
                    success(serviceResponse)
                }
            default:
                DispatchQueue.main.async {
                    failure(serviceResponse)
                }
            }
        }

        serviceTask.resume()
    }
}


