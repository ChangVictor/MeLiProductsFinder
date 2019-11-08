//
//  MeLiProductsFinderUITests.swift
//  MeLiProductsFinderUITests
//
//  Created by Victor Chang on 08/11/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import XCTest

class MeLiProductsFinderUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app.terminate()
    }

    func testSearchWithResultsFlow() {
        
        let searchButton = app.buttons["Buscar"]
        XCTAssertEqual(searchButton.isEnabled, false)

        app.textFields["Buscar en Mercado Libre"].tap()
        app.textFields["Buscar en Mercado Libre"].typeText("iphone x")
        searchButton.tap()

        let searchResult = app.collectionViews.cells.element
        XCTAssertTrue(searchResult.waitForExistence(timeout: 5), "Result exists for search")
        
        app.collectionViews.cells.element(boundBy: 1).tap()
        
        let itemDetailBackButton = app.navigationBars.buttons["Back"]
        XCTAssertTrue(itemDetailBackButton.exists, "Item detail presented")
        
        app.navigationBars.buttons["Back"].tap()
        app.navigationBars.buttons["Back"].tap()
    
        XCTAssertEqual(searchButton.isEnabled, false)
    }
}
