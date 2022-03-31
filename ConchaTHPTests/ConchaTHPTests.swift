//
//  ConchaTHPTests.swift
//  ConchaTHPTests
//
//  Created by Shanezzar Sharon on 28/03/2022.
//

import XCTest
@testable import ConchaTHP
import Combine

class ConchaTHPTests: XCTestCase {

    // MARK: - Variables
    
    var cancellables = Set<AnyCancellable>()
    
    
    // MARK: - Methods
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func test_ViewModel_concha_ticks_shouldBeEmpty() {
        // Given
        let model = ViewModel()
        
        // When
        let ticks = model.concha.ticks
        
        // Then
        XCTAssertNil(ticks)
    }
    
    func test_ViewModel_fetch_shouldReturnTicks() {
        // Given
        let model = ViewModel()
        
        // When
        let expectation = XCTestExpectation(description: "Should return items.")
        
        model.$concha
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        model.fetch(for: .start, ["choice": "start"])
        
        // Then
        wait(for: [expectation], timeout: 30)
        XCTAssertGreaterThan(model.concha.ticks!.count, 0)
    }
    
    // Above are tests I wrote as sample, other test are similar in one way or the other.

}
