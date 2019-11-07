//
//  MeLiProductsFinderUITests.swift
//  MeLiProductsFinderUITests
//
//  Created by Victor Chang on 07/11/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import XCTest
@testable import MeLiProductsFinder

class MeLiProductsFinderUITests: XCTestCase {

    var controller: SearchController!
    override func setUp() {
        controller = SearchController()
        super.setUp()
    }

    override func tearDown() {
        controller = nil
        super.tearDown()
        
    }

    func testSearchButton() {
        
        controller.searchButton.isEnabled = controller.searchTextField.text!.count >= 3 ? true : false
        
        XCTAssertEqual(controller.searchButton.isEnabled, false)
    }
}
