//
//  GroceryWorker.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright (c) 2019 Alejandro Orozco Builes. All rights reserved.
//

import UIKit

class GroceryWorker: BaseWorker {

    /// Retrieves the Manager's Special
    /// - Parameter completionHandler: <Grocery.Response, Error>
    func getStoreFilters(completionHandler: @escaping (Result<Grocery.Response.Data, Error>) -> Void) {

        guard let request = makeRequest(path: URLOperations.getManagersSpecials.path, request: Optional<String>.none) else {
            completionHandler(.failure(ServiceError.UnableToCreateRequest))
            return
        }

        let response = makeResponse(Grocery.Response.Data.self) { (result) in
            completionHandler(result)
        }

        ApiManager.shared.serviceRequest(path: request.path,
                                         method: .GET,
                                         encodeData: request.data,
                                         headers: nil,
                                         success: response.success,
                                         failure: response.failure)
    }

}
