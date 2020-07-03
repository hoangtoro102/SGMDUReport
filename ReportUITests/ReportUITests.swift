//
//  ReportUITests.swift
//  ReportUITests
//
//  Created by HoangNguyen on 7/1/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import XCTest

class ReportUITests: XCTestCase {

    func testTableInteraction() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.waitForExistence(timeout: 1))

        let actExists = app.activityIndicators.firstMatch.waitForExistence(timeout: 30)
        XCTAssertTrue(actExists)
        
        let tableView = app.tables.element.firstMatch
        XCTAssertTrue(tableView.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
