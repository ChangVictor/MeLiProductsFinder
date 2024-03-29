//
//  MeLiProductsFinderTests.swift
//  MeLiProductsFinderTests
//
//  Created by Victor Chang on 07/11/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import XCTest
@testable import MeLiProductsFinder

var sut: URLSession!
var service: Service!

class MeLiProductsFinderTests: XCTestCase {

    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
        service = Service()
    }

    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }

    func testValidCallToServiceGetsHTTPStatusCode200() {

        let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=IPad%20Pro%20&offset=0&limit=20")

        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          if let error = error {
            XCTFail("Error: \(error.localizedDescription)")
              return
            } else if let statusCode = (response as?  HTTPURLResponse)?.statusCode {
              if statusCode == 200 {
                promise.fulfill()
              } else {
                XCTFail("Status code: \(statusCode)")
            }
          }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func testServiceSearchDidCompleteWithResult() {
        
        let didFinish = self.expectation(description: "Completion handler called")
        var result: SearchResult?
        var responseError: Error?
        service.fetchItems(searchTerm: "iPhone") { response, error in
            
            if let error = error {
                Logger.print(error.localizedDescription)
            }
            responseError = error
            result = response
            didFinish.fulfill()
        }
        
        wait(for: [didFinish], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertNotNil(result)
    }
    
}
