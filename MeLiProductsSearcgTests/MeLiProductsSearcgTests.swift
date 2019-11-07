//
//  MeLiProductsSearcgTests.swift
//  MeLiProductsSearcgTests
//
//  Created by Victor Chang on 07/11/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import XCTest
@testable import MeLiProductsFinder

var sut: Service!

class MeLiProductsSearcgTests: XCTestCase {

    override func setUp() {
        super.setUp()
        sut = Service()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSearchWithSignaling() {
        
        let didFinish = self.expectation(description: "#function")
        var result: SearchResult?
        sut.fetchItems(searchTerm: "iPhone") { response, error in
            
            if let error = error {
                Logger.print(error.localizedDescription)
            }
            
            result = response
            didFinish.fulfill()
        }
        
        wait(for: [didFinish], timeout: 5)
        XCTAssertNoThrow(try result?.get())
    }
}
