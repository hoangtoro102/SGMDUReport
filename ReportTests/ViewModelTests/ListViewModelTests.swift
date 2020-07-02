//
//  ListViewModelTests.swift
//  ReportTests
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import XCTest
@testable import Report

class ListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testParserMethod() throws {
        //Given
        let index = 0
        let givenItem = DisplayItem(year: 2018, volumeOfYear: 10.1, records: [], decrease: false)
        
        //When
        let report = try ResourceLoader.loadReport(resource: .fetchResource)
        let collection = DisplayItemCollection(report: report)
        
        //Then
        XCTAssertEqual(collection.items[index].year, givenItem.year)
    }
}
