//
//  DisplayItemCollection.swift
//  Report
//
//  Created by HoangNguyen on 7/1/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

final class DisplayItemCollection {
    var items = [DisplayItem]()
    
    init(report: ReportModel) {
        self.items = []
        if report.result.records.count < 1 {
            return
        }
        self.items = DisplayItemCollection.parsedItems(records: report.result.records)
    }
    
    private static func parsedItems(records: [RecordModel]) -> [DisplayItem] {
        var result = [DisplayItem]()
        
        var lastItemYear = 0
        var volumeOfYear = 0.0
        var recordList = [RecordModel]()
        for record in records {
            let yearNumber = Int(record.quarter.components(separatedBy: "-")[0]) ?? 0
            if yearNumber > 2007 {
                if lastItemYear != 0 && yearNumber != lastItemYear {
                    var decrease = false
                    if result.count > 0 {
                        decrease = result.last?.volumeOfYear ?? 0 < volumeOfYear
                    }
                    let item = DisplayItem(year: lastItemYear, volumeOfYear: volumeOfYear, records: recordList, decrease: decrease)
                    result.append(item)

                    volumeOfYear = 0
                    recordList = []
                }
                if yearNumber < 2019 {
                    lastItemYear = yearNumber
                    volumeOfYear += record.volume
                    recordList.append(record)
                }
            } else {
                print("Year \(yearNumber) is not in range 2008-2018")
            }
        }
        return result.sorted { $0.year > $1.year }
    }
}