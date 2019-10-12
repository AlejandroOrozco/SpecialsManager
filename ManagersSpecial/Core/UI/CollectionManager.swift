//
//  CollectionManager.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 10/10/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import SwiftUI

protocol SizableElement {
    var size: CGSize { set get }
}

struct CollectionManager {

    let viewSize: CGSize
    let canvasUnit: Int
    let minimunSpacing: CGFloat

    /// CollectionManager organizes any number of SizableElements by creating a matrix, using the width as the main
    /// factor to suit each element for a given canvas
    /// - Parameter viewSize: CGSize of the container view
    /// - Parameter canvasUnit: Maximun width of the container view
    /// - Parameter minimunSpacing: Minimun space between each element per row
    init(viewSize: CGSize, canvasUnit: Int, minimunSpacing: CGFloat = 0) {
        self.viewSize = viewSize
        self.canvasUnit = canvasUnit
        self.minimunSpacing = minimunSpacing
    }

    /// Will return a suitable collection given the specified canvas unit of the collection manager
    /// - Parameter elements: An array of SizableElements that will be converted to a matrix of SizableElements
    func suitableCollection<E: SizableElement>(for elements: [E]) -> [[E]] {
        var matrixArrangement: [[E]] = []
        var arrangement: [E] = []
        var usedCanvasUnits: Int = 0
        var addedToReArrangement = false

        for element in elements {
            if (usedCanvasUnits + Int(element.size.width)) <= canvasUnit {
                usedCanvasUnits += Int(element.size.width)
                arrangement.append(sizedElement(for: element))
                addedToReArrangement = false
            } else {
                matrixArrangement.append(arrangement)
                arrangement = [sizedElement(for: element)]
                usedCanvasUnits = Int(element.size.width)
                addedToReArrangement = true
            }
        }

        if !addedToReArrangement {
            matrixArrangement.append(arrangement)
        }

        return matrixArrangement
    }

    /// Turns the containers width into canvas unit points
    private var sizeUnit: CGFloat {
        return (viewSize.width) / CGFloat(canvasUnit)
    }


    /// Recalculte the size for a given SizableElement, by using the canvasPoints provided
    /// - Parameter sizableElement: a SizableElement already cofigured by the given canvas
    private func sizedElement<E: SizableElement>(for sizableElement: E) -> E {
        var sizableElement = sizableElement
        sizableElement.size.height = sizableElement.size.height * sizeUnit
        sizableElement.size.width = sizableElement.size.width * (sizeUnit - minimunSpacing)
        return sizableElement
    }

}
