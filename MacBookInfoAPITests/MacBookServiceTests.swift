//
//  MacBookServiceTests.swift
//  MacBookInfoAPITests
//
//  Created by Sireesha Siddineni on 26/06/24.
//

import XCTest
import Combine
@testable import MacBookInfoAPI

class MacBookServiceTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    var macBookService: MacBookService!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        macBookService = MacBookService()
    }
    
    override func tearDown() {
        cancellables = nil
        macBookService = nil
        super.tearDown()
    }
    
    func testFetchMacBookSuccess() {
        let expectation = XCTestExpectation(description: "Fetch MacBook details from API")
        
        macBookService.fetchMacBook(id: "7")
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            } receiveValue: { macBook in
                XCTAssertNotNil(macBook, "MacBook should not be nil")
                XCTAssertEqual(macBook.id, "7")
                XCTAssertEqual(macBook.name, "Apple MacBook Pro 16")
                XCTAssertEqual(macBook.data.year, 2019)
                XCTAssertEqual(macBook.data.price, 1849.99)
                XCTAssertEqual(macBook.data.cpuModel, "Intel Core i9")
                XCTAssertEqual(macBook.data.hardDiskSize, "1 TB")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}
