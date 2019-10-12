//
//  BaseWorker.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import Foundation

class BaseWorker {
    func makeRequest<I: Encodable>(path: String, request: I?) -> ((path: URL, data: Data?)?) {

        guard let url = URL(string: path) else {
            return nil
        }

        guard let request = request else {
            return (url, nil)
        }

        guard let data = try? JSONEncoder().encode(request) else {
            return nil
        }

        return (url, data)
    }

    func makeResponse<O: Decodable>(_ response: O.Type, completionHandler: @escaping (Result<O, Error>) -> ()) -> (success: ServiceSuccess, failure: ServiceFailure) {

        let success: ServiceSuccess = { result in
            guard let data = result.entireResponse,
                let orderResponse = try? JSONDecoder().decode(O.self, from: data) else {
                    completionHandler(.failure(ServiceError.UnableToParseResponse))
                    return
            }
            completionHandler(.success(orderResponse))
        }

        let failure: ServiceFailure = { result in
            completionHandler(.failure(ServiceError.ErrorResponse(error: result.error)))
        }

        return (success, failure)
    }
}
