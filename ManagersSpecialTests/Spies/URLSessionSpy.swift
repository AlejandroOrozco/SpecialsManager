//
//  URLSessionSpy.swift
//  ManagersSpecialTests
//
//  Created by Alejandro Orozco Builes on 11/10/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import Foundation
@testable import ManagersSpecial

class URLSessionDataTaskSpy: URLSessionDataTaskProtocol {
    func resume() {}
}

class URLSessionSpy: URLSessionProtocol {

    var data: Data?
    var error: Error?

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        if let data = data {
            completionHandler(data, HTTPURLResponse(url: URL(string: "sessionSpy")!, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        }

        if let error = error {
            completionHandler(nil, HTTPURLResponse(url: URL(string: "sessionSpy")!, statusCode: 400, httpVersion: nil, headerFields: nil), error)
        }
        return URLSessionDataTaskSpy()
    }

}
