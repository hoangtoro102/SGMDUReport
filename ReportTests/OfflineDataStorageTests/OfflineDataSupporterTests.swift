//
//  OfflineDataSupporterTests.swift
//  ReportTests
//
//  Created by HoangNguyen on 7/3/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import XCTest
@testable import Report

class OfflineDataSupporterTests: XCTestCase {
    func testSaveOfflineData() throws {
        //Given
        let report = try ResourceLoader.loadReport(resource: .fetchResource)
        //When
        OfflineDataSupporter.setOfflineReportData(model: report)
        let offlineData = OfflineDataSupporter.getOfflineReportData()
        
        //Then
        XCTAssert(offlineData != nil)
    }
}
