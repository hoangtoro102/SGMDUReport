//
//  ReportModel.swift
//  Report
//
//  Created by HoangNguyen on 7/1/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

struct ReportModel: Codable {
    let success: Bool
    let result: ResultModel
    
    init() {
        self.success = true
        self.result = ResultModel(total: 0, records: [])
    }
}
