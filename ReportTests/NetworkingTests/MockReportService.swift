//
//  MockReportService.swift
//  ReportTests
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import RxSwift

@testable import Report

class MockReportService: ReportServiceProtocol {
    
    var report: ReportModel?
    let urlReq: URLRequest = URLRequest(url: URL(string: "fakeURL")!)
    
    func fetchReportData() -> Observable<ReportModel> {
        return apiRequestReport(urlReq)
    }
    
    func apiRequestReport(_ urlRequest: URLRequest) -> Observable<ReportModel> {
        return Observable<ReportModel>.create {
            observer in
            observer.onNext(self.report!)
            observer.onCompleted()
            return Disposables.create {
            }
        }
    }
}
