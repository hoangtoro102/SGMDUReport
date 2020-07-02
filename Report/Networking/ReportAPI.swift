//
//  ReportAPI.swift
//  Report
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

enum ReportAPI {
    case fetchReport
}

extension ReportAPI: APISetting {
    var path: String {
        switch self {
        case .fetchReport: return EndPointType.sources.rawValue
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .fetchReport: return ["resource_id" : "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"]
        }
    }
}
