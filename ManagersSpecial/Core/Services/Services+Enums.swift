//
//  Services+Enums.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import Foundation

enum URLOperations {
    case getManagersSpecials

    var path: String {
        switch self {
        case .getManagersSpecials:
            return "\(BASE_URI)/ios-coding-challenge"
        }
    }
}

enum ServiceError: Error {
    case UnableToCreateRequest
    case UnableToParseResponse
    case ErrorResponse(error: Error?)
}

enum ServiceErrorMessages: String {
    case title = "An error has occurred 😔"
    case `default` = "Please try again at another time."
}
