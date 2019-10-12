//
//  AlertMessage.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 11/10/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import Foundation

enum AlertType {
    case Error, Information
}

struct AlertMessage {
    var title: String
    var message: String
    var type: AlertType
}
