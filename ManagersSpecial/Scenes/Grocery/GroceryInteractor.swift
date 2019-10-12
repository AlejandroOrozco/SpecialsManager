//
//  GroceryInteractor.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright (c) 2019 Alejandro Orozco Builes. All rights reserved.
//

import UIKit

protocol GroceryBusinessLogic {
    func getManagersSpecials()
}

protocol GroceryDataStore {
    //var name: String { get set }
}

class GroceryInteractor: GroceryBusinessLogic, GroceryDataStore {
    var presenter: GroceryPresentationLogic?
    var worker: GroceryWorker = GroceryWorker()

    func getManagersSpecials() {
        worker.getStoreFilters(completionHandler: { [weak self] (result) in
            switch(result) {
            case .success(let managersSpecials):
                self?.presenter?.presentManagersSpecials(managersSpecials: managersSpecials)
            case .failure(let error):
                self?.presenter?.presentError(error: error)
            }
        })
    }
}
