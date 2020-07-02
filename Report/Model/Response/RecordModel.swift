//
//  RecordModel.swift
//  Report
//
//  Created by HoangNguyen on 7/1/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

struct RecordModel: Codable {
    let id: Int
    private let sVolume: String
    var volume: Double { return Double(sVolume) ?? 0.0 }
    let quarter: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sVolume = "volume_of_mobile_data"
        case quarter
    }
}
