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
    let volume: Double
    let quater: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case volume = "volume_of_mobile_data"
        case quater
    }
}
