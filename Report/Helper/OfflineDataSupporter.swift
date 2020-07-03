//
//  OfflineDataSupporter.swift
//  Report
//
//  Created by HoangNguyen on 7/3/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
public class OfflineDataSupporter {
    static func getOfflineReportData() -> ReportModel? {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "OfflineReportData") {
            let result = try? JSONDecoder().decode(ReportModel.self, from: data)
            return result
        }
        return nil
    }
    
    static func setOfflineReportData(model: ReportModel) {
        if let data = try? JSONEncoder().encode(model) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "OfflineReportData")
        }
    }
}
