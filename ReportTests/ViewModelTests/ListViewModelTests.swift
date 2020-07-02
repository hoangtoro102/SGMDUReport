//
//  ListViewModelTests.swift
//  ReportTests
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import XCTest
import RxBlocking
import RxSwift
@testable import Report

class ListViewModelTests: XCTestCase {
    
    var service: MockReportService!
    
    override func setUp() {
        service = MockReportService()
    }
    
    override func tearDown() {
        service = nil
    }
    
    func testParserMethod() throws {
        //Given
        let index = 0
        let givenItem = DisplayItem(year: 2018, volumeOfYear: 75.35964842, records: [], decrease: false)
        
        //When
        let report = try ResourceLoader.loadReport(resource: .fetchResource)
        let collection = DisplayItemCollection(report: report)
        
        //Then
        XCTAssertEqual(collection.items[index].year, givenItem.year)
        XCTAssertEqual(collection.items[index].volumeOfYear, givenItem.volumeOfYear)
        XCTAssertEqual(collection.items[index].decrease, givenItem.decrease)
    }
    
    func testFetchDataWhenInitialized() throws {
        //Given
        let report = try ResourceLoader.loadReport(resource: .fetchResource)
        let collection = DisplayItemCollection(report: report)
        
        //When
        
        
        //Then
    }
}
