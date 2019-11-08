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

    func testSearch() {
        
        app.textFields["Buscar en Mercado Libre"].tap()
        app.textFields["Buscar en Mercado Libre"].typeText("iphone x")
        app.buttons["Buscar"].tap()
        
        let searchResult = app.collectionViews.cells.element
        
        XCTAssertTrue(searchResult.waitForExistence(timeout: 5), "Result exists for search")
//        XCTAssertTrue(searchResult.exists, "result exists")
        
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
