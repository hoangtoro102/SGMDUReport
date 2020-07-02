//
//  ResultModel.swift
//  Report
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
struct ResultModel: Codable {
    let total: Int
    let records: [RecordModel]
}
