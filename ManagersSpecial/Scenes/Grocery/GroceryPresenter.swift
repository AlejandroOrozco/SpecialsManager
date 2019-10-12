//
//  GroceryPresenter.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright (c) 2019 Alejandro Orozco Builes. All rights reserved.
//

import UIKit

protocol GroceryPresentationLogic {
    func presentManagersSpecials(managersSpecials: Grocery.Response.Data)
    func presentError(error: Error)
}

class GroceryPresenter: GroceryPresentationLogic {
    weak var viewController: GroceryDisplayLogic?

    func presentManagersSpecials(managersSpecials: Grocery.Response.Data) {
        let specials = managersSpecials.managerSpecials.map {
            Grocery.ViewModel.ManagerSpecial(name: $0.displayName,
                                             imageURL: URL(string: $0.imageURL),
                                             size: .init(width: $0.width, height: $0.height),
                                             originalPrice: "$\($0.originalPrice)",
                                             currentPrice: "$\($0.price)")
        }

        viewController?.displayManagersSpecials(canvasUnit: managersSpecials.canvasUnit, managersSpecials: specials)
    }

    func presentError(error: Error) {
        switch error as? ServiceError {
        case .ErrorResponse(let serviceError) where !(serviceError is ServiceError):
            viewController?.displayAlertMessage(alertMessage: .init(title: ServiceErrorMessages.title.rawValue,
                                                                    message: serviceError?.localizedDescription ?? ServiceErrorMessages.default.rawValue,
                                                                    type: .Error))
        default:
            viewController?.displayAlertMessage(alertMessage: .init(title: ServiceErrorMessages.title.rawValue,
                                                                    message: ServiceErrorMessages.default.rawValue,
                                                                    type: .Error))
        }
    }
}
