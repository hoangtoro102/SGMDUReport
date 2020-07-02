//
//  ReportApiTests.swift
//  ReportTests
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import XCTest
import RxBlocking
@testable import Report

class ReportApiTests: XCTestCase {

    var reportApiFetch: ReportAPI!
    
    override func setUp() {
        reportApiFetch = ReportAPI.fetchReport
    }
    
    override func tearDown() {
        reportApiFetch = nil
    }

    func testReportAPICreatesURLString() {
        //Given
        let urlTest = "https://data.gov.sg/api/action/datastore_search"
        XCTAssertEqual(reportApiFetch.createUrlString(), urlTest)
    }
}
