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
    var viewModel: ListViewModel!
    
    override func setUp() {
        service = MockReportService()
        viewModel = ListViewModel(service)
    }
    
    override func tearDown() {
        service = nil
        viewModel = nil
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
    
    func testViewModelFetchDataWhenInitialized() throws {
        //Given
        let report = try ResourceLoader.loadReport(resource: .fetchResource)
        service.report = report
        let collection = DisplayItemCollection(report: report)
        
        //When
        viewModel.loadDataTrigger.onNext(())
        
        //Then
        XCTAssertEqual(try viewModel.collection.toBlocking().first()?.items.count, collection.items.count)
        XCTAssertEqual(try viewModel.collection.toBlocking().first()?.items.first?.year, collection.items.first?.year)
        XCTAssertEqual(try viewModel.collection.toBlocking().first()?.items.first?.volumeOfYear, collection.items.first?.volumeOfYear)
    }
}
