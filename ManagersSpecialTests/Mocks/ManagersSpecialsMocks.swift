//
//  ManagersSpecialsMocks.swift
//  ManagersSpecialTests
//
//  Created by Alejandro Orozco Builes on 11/10/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import Foundation
@testable import ManagersSpecial

enum ManagersSpecialsMocks {
    enum Response {

        static var RawData: Data? {
            if let filePath = Bundle(for: GroceryWorkerTests.self).path(forResource: "ManagersSpecials", ofType: "json"),
                let contentFile = try? String(contentsOfFile: filePath) {
                return contentFile.data(using: .utf8)
            }
            return nil
        }

        static var ResponseWithData: Grocery.Response.Data {
            return .init(canvasUnit: 16,
                         managerSpecials: [ .init(displayName: "Noodle Dish with Roasted Black Bean Sauce",
                                                  height: 8,
                                                  imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/L.png",
                                                  originalPrice: "2.00",
                                                  price: "1.00",
                                                  width: 16),
                                            .init(displayName: "Noodle Dish with Roasted Black Bean Sauce",
                                                  height: 8,
                                                  imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/L.png",
                                                  originalPrice: "2.00",
                                                  price: "1.00",
                                                  width: 8),
                                            .init(displayName: "Noodle Dish with Roasted Black Bean Sauce",
                                                  height: 8,
                                                  imageURL: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/L.png",
                                                  originalPrice: "2.00",
                                                  price: "1.00",
                                                  width: 8)
            ])
        }

        static var ResponseWithFailure: Error {
            return ServiceError.ErrorResponse(error: nil)
        }

        static var ResponseFromJSON: [Grocery.Response.ManagerSpecial] {
            return try! JSONDecoder().decode(Grocery.Response.Data.self, from: RawData!).managerSpecials
        }
    }

    enum ViewModel {
        static var Specials: [Grocery.ViewModel.ManagerSpecial] {
            return Response.ResponseFromJSON.map {
                Grocery.ViewModel.ManagerSpecial(name: $0.displayName,
                                                 imageURL: URL(string: $0.imageURL),
                                                 size: .init(width: 100, height: 100),
                                                 originalPrice: "$2.00",
                                                 currentPrice: "1.00") }
        }
    }
}
