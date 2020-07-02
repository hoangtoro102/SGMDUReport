//
//  DisplayItemCollection.swift
//  Report
//
//  Created by HoangNguyen on 7/1/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import RxDataSources

final class DisplayItemCollection {
    var items = [DisplayItem]()
    
    convenience init() {
        self.init(report: ReportModel())
    }
    
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
                    let item = DisplayItem(year: lastItemYear, volumeOfYear: volumeOfYear, records: recordList, decrease: false)
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
        let sortedList = result.sorted { $0.year > $1.year }
        var i = 0
        while i < sortedList.count - 1 {
            sortedList[i].decrease = sortedList[i+1].volumeOfYear > sortedList[i].volumeOfYear
            i+=1
        }
        return sortedList
    }
}
struct PresentationSection {
    var header: String
    var items: [DisplayItem]
}

extension PresentationSection: SectionModelType {
    init(original: PresentationSection, items: [DisplayItem]) {
        self = original
        self.items = items
    }
}
