//
//  DisplayItem.swift
//  Report
//
//  Created by HoangNguyen on 7/1/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

final class DisplayItem {
    let year: Int
    let volumeOfYear: Double
    let records: [RecordModel]
    var decrease: Bool
    
    init(year: Int, volumeOfYear: Double, records: [RecordModel], decrease: Bool) {
        self.year = year
        self.volumeOfYear = volumeOfYear
        self.records = records
        self.decrease = decrease
    }
}
