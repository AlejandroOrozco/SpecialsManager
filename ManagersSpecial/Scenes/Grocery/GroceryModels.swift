//
//  GroceryModels.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright (c) 2019 Alejandro Orozco Builes. All rights reserved.
//

import SwiftUI

enum Grocery
{
    enum Response {

        struct Data: Decodable {
            let canvasUnit: Int
            let managerSpecials: [ManagerSpecial]
        }

        struct ManagerSpecial: Decodable {
            let displayName: String
            let height: Int
            let imageURL: String
            let originalPrice, price: String
            let width: Int

            enum CodingKeys: String, CodingKey {
                case displayName = "display_name"
                case height
                case imageURL = "imageUrl"
                case originalPrice = "original_price"
                case price, width
            }
        }
    }

    enum ViewModel {
        struct ManagerSpecial: Identifiable, SizableElement {
            let id = UUID()
            let name: String
            let imageURL: URL?
            var size: CGSize
            let originalPrice: String
            let currentPrice: String

            var accessibilityLabel: String {
                return "Order \(name) for  \(currentPrice), normally \(originalPrice)"
            }
        }
    }
}
