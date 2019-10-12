//
//  GroceryController.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright (c) 2019 Alejandro Orozco Builes. All rights reserved.
//

import Combine
import SwiftUI

protocol GroceryDisplayLogic: class {
    func displayManagersSpecials(canvasUnit: Int, managersSpecials: [Grocery.ViewModel.ManagerSpecial])
    func displayAlertMessage(alertMessage: AlertMessage)
}

class GroceryController: GroceryDisplayLogic, ObservableObject {
    var interactor: GroceryBusinessLogic?
    private var collectionManager: CollectionManager?
    private var unsuitedManagersSpecials: [Grocery.ViewModel.ManagerSpecial] = []

    @Published var managersSpecials: [[Grocery.ViewModel.ManagerSpecial]] = []
    @Published var showAlertMessage: Bool = false

    var alertMessage: AlertMessage? {
        didSet {
            showAlertMessage = true
        }
    }

    init() {
        setup()
        interactor?.getManagersSpecials()
        subscribeToDeviceRotation()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = GroceryInteractor()
        let presenter = GroceryPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    private func subscribeToDeviceRotation() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateLayout(notification:)), name: .deviceWillRotate, object: nil)
    }

    @objc private func updateLayout(notification: Notification) {
        if let collectionManager = collectionManager, !unsuitedManagersSpecials.isEmpty {
            managersSpecials = collectionManager.suitableCollection(for: unsuitedManagersSpecials)
        }
    }

    // MARK: - GroceryDisplayLogic - Implementation

    func displayManagersSpecials(canvasUnit: Int, managersSpecials: [Grocery.ViewModel.ManagerSpecial]) {
        let collectionManager = CollectionManager(viewSize: UIScreen.main.bounds.size,
                                                  canvasUnit: canvasUnit,
                                                  minimunSpacing: 3)
        self.collectionManager = collectionManager
        self.unsuitedManagersSpecials = managersSpecials
        self.managersSpecials = collectionManager.suitableCollection(for: managersSpecials)
    }

    func displayAlertMessage(alertMessage: AlertMessage) {
        self.alertMessage = alertMessage
    }
}
