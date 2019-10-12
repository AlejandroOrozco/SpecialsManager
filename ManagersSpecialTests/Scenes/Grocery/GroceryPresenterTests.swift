//
//  GroceryPresenterTests.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright (c) 2019 Alejandro Orozco Builes. All rights reserved.
//

@testable import ManagersSpecial
import XCTest

class GroceryPresenterTests: XCTestCase
{
    // MARK: Subject under test

    var sut: GroceryPresenter!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupGroceryPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupGroceryPresenter() {
        sut = GroceryPresenter()
    }

    // MARK: Test doubles

    class GroceryDisplayLogicSpy: GroceryDisplayLogic {
        var managersSpecials: [Grocery.ViewModel.ManagerSpecial]?
        var alertMessage: AlertMessage?

        func displayManagersSpecials(canvasUnit: Int, managersSpecials: [Grocery.ViewModel.ManagerSpecial]) {
            self.managersSpecials = managersSpecials
        }

        func displayAlertMessage(alertMessage: AlertMessage) {
            self.alertMessage = alertMessage
        }
    }

    // MARK: PresentManagersSpecials

    func testPresentManagersSpecialsShouldCreateACollectionOfManagersSpecials() {
        // Given
        let spy = GroceryDisplayLogicSpy()
        sut.viewController = spy
        let response = ManagersSpecialsMocks.Response.ResponseWithData

        // When
        sut.presentManagersSpecials(managersSpecials: response)

        // Then
        XCTAssertNotNil(spy.managersSpecials)
    }

    // MARK: PresentError

    func testPresentErrorWithServiceErrorShouldDisplayAnErrorAlertMessage() {
        // Given
        let spy = GroceryDisplayLogicSpy()
        sut.viewController = spy
        let error = ServiceError.ErrorResponse(error: NSError(domain: "",
                                                              code: 404,
                                                              userInfo: [NSLocalizedDescriptionKey: "Page not found"]))

        // When
        sut.presentError(error: error)

        // Then
        XCTAssertNotNil(spy.alertMessage)
        XCTAssertEqual(spy.alertMessage?.title, Optional("An error has occurred 😔"))
        XCTAssertEqual(spy.alertMessage?.message, Optional("Page not found"))
        XCTAssertTrue(spy.alertMessage?.type == Optional(AlertType.Error))
    }

    func testPresentErrorWithEmptyServiceErrorShouldDisplayAnErrorAlertMessage() {
        // Given
        let spy = GroceryDisplayLogicSpy()
        sut.viewController = spy
        let error = ServiceError.ErrorResponse(error: nil)

        // When
        sut.presentError(error: error)

        // Then
        XCTAssertNotNil(spy.alertMessage)
        XCTAssertEqual(spy.alertMessage?.title, Optional("An error has occurred 😔"))
        XCTAssertEqual(spy.alertMessage?.message, Optional("Please try again at another time."))
        XCTAssertTrue(spy.alertMessage?.type == Optional(AlertType.Error))
    }


    func testPresentErrorWithClientErrorShouldDisplayAnErrorAlertMessage() {
        // Given
        let spy = GroceryDisplayLogicSpy()
        sut.viewController = spy
        let error = ServiceError.ErrorResponse(error: ServiceError.UnableToParseResponse)

        // When
        sut.presentError(error: error)

        // Then
        XCTAssertNotNil(spy.alertMessage)
        XCTAssertEqual(spy.alertMessage?.title, Optional("An error has occurred 😔"))
        XCTAssertEqual(spy.alertMessage?.message, Optional("Please try again at another time."))
        XCTAssertTrue(spy.alertMessage?.type == Optional(AlertType.Error))
    }

}
