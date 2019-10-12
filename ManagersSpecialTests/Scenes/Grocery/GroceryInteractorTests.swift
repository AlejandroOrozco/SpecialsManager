//
//  GroceryInteractorTests.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright (c) 2019 Alejandro Orozco Builes. All rights reserved.
//

@testable import ManagersSpecial
import XCTest

class GroceryInteractorTests: XCTestCase
{
    // MARK: Subject under test

    var sut: GroceryInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupGroceryInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupGroceryInteractor() {
        sut = GroceryInteractor()
    }

    // MARK: Test doubles

    class GroceryPresentationLogicSpy: GroceryPresentationLogic {
        var managersSpecials: Grocery.Response.Data?
        var error: Error?

        func presentManagersSpecials(managersSpecials: Grocery.Response.Data) {
            self.managersSpecials = managersSpecials
        }

        func presentError(error: Error) {
            self.error = error
        }
    }

    class GroceryWorkerSpy: GroceryWorker {
        var success: Grocery.Response.Data?
        var failure: Error?

        override func getStoreFilters(completionHandler: @escaping (Result<Grocery.Response.Data, Error>) -> Void) {
            if let success = success {
                completionHandler(.success(success))
            }
            if let failure = failure {
                completionHandler(.failure(failure))
            }
        }
    }

    // MARK: Tests GetManagersSpecials

    func testGetManagersSpecialsWithSuccessResponseShouldPresentManagersSpecials() {
        // Given
        let spy = GroceryPresentationLogicSpy()
        let worker = GroceryWorkerSpy()
        sut.presenter = spy
        sut.worker = worker
        worker.success = ManagersSpecialsMocks.Response.ResponseWithData
        // When
        sut.getManagersSpecials()

        // Then
        XCTAssertNil(spy.error)
        XCTAssertNotNil(spy.managersSpecials)
    }

    func testGetManagersSpecialsWithErrorResponseShouldPresentManagersSpecials() {
        // Given
        let spy = GroceryPresentationLogicSpy()
        let worker = GroceryWorkerSpy()
        sut.presenter = spy
        sut.worker = worker
        worker.failure = ManagersSpecialsMocks.Response.ResponseWithFailure
        // When
        sut.getManagersSpecials()

        // Then
        XCTAssertNil(spy.managersSpecials)
        XCTAssertNotNil(spy.error)
    }
}
