//
//  GroceryControllerTests.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright (c) 2019 Alejandro Orozco Builes. All rights reserved.
//

@testable import ManagersSpecial
import XCTest

class GroceryControllerTests: XCTestCase
{
    // MARK: Subject under test

    var sut: GroceryController?

    // MARK: Test lifecycle

    override func setUp()
    {
        super.setUp()
        setUpController()
    }

    override func tearDown()
    {
        super.tearDown()
    }

    func setUpController() {
        sut = GroceryController()
    }

    // MARK: Tests

    func testDisplayManagersShouldPublishTheSpecialManagers() {
        // When
        sut?.displayManagersSpecials(canvasUnit: 160, managersSpecials: ManagersSpecialsMocks.ViewModel.Specials)
        // Then

        XCTAssertFalse(sut?.managersSpecials.isEmpty ?? true)
        XCTAssertNil(sut?.alertMessage)

        // Testing CollectionManager
    }

    func testDisplayAlertMessaShouldPublishAlertMessage() {
        // When
        sut?.displayAlertMessage(alertMessage: .init(title: "Mock", message: "Test", type: .Information))
        // Then
        XCTAssertNotNil(sut?.alertMessage)
        XCTAssertTrue(sut?.managersSpecials.isEmpty ?? false)
    }

}
