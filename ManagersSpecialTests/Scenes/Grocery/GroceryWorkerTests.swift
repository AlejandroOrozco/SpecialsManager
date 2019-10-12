//
//  GroceryWorkerTests.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright (c) 2019 Alejandro Orozco Builes. All rights reserved.
//

@testable import ManagersSpecial
import XCTest

class GroceryWorkerTests: XCTestCase
{
    // MARK: Subject under test

    var sut: GroceryWorker!
    var sessionSpy: URLSessionSpy!

    // MARK: Test lifecycle

    override func setUp()
    {
        super.setUp()
        setupGroceryWorker()
    }

    override func tearDown()
    {
        super.tearDown()
    }

    // MARK: Test setup

    func setupGroceryWorker()
    {
        sut = GroceryWorker()
        sessionSpy = URLSessionSpy()
        ApiManager.shared.session = sessionSpy
    }

    // MARK: Tests

    func testGetStoreFiltersWithAProperRequestShouldRetrieveASuccesfulResponse() {
        // Given
        let expectation = XCTestExpectation(description: "Testing async task")
        sessionSpy.data = ManagersSpecialsMocks.Response.RawData
        // When
        sut.getStoreFilters { (result) in
            // Then
            switch result {
            case .success(let managersSpecials):
                XCTAssertEqual(managersSpecials.canvasUnit, 16)
                XCTAssertEqual(managersSpecials.managerSpecials.count, 21)
            case .failure(_):
                XCTFail("Should not retrieve error")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testGetStoreFiltersWithBadRequestShouldRetrieveAnErrorResponse() {
        // Given
        let expectation = XCTestExpectation(description: "Testing async task")
        sessionSpy.error = ServiceError.ErrorResponse(error: nil)
        // When
        sut.getStoreFilters { (result) in
            // Then
            switch result {
            case .success(_):
                XCTFail("Should not retrieve managersSpecials")
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertTrue(error is ServiceError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
}
