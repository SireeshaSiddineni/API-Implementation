//
//  MacBookViewModelTests.swift
//  MacBookInfoAPITests
//
//  Created by Sireesha Siddineni on 26/06/24.
//

import XCTest
import Combine
@testable import MacBookInfoAPI

class MacBookViewModelTests: XCTestCase {
    var viewModel: MacBookViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchMacBookSuccess() {
        viewModel = MacBookViewModel()
        let expectation = XCTestExpectation(description: "Fetch MacBook details from API")
        
        viewModel.fetchMacBook(id: "7")
        
        viewModel.$macBook
            .dropFirst()
            .sink { macBook in
                XCTAssertNotNil(macBook, "MacBook should not be nil")
                XCTAssertEqual(macBook?.id, "7")
                XCTAssertEqual(macBook?.name, "Apple MacBook Pro 16")
                XCTAssertEqual(macBook?.data.year, 2019)
                XCTAssertEqual(macBook?.data.price, 1849.99)
                XCTAssertEqual(macBook?.data.cpuModel, "Intel Core i9")
                XCTAssertEqual(macBook?.data.hardDiskSize, "1 TB")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFetchMacBookFailure() {
        let macBookService = MacBookService()
        viewModel = MacBookViewModel(macBookService: macBookService)
        let expectation = XCTestExpectation(description: "Fetch MacBook details from API with invalid ID")
        
        viewModel.fetchMacBook(id: "invalid_id")
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage, "Error message should not be nil")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}
