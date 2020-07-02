//
//  ResourceLoader.swift
//  ReportTests
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
@testable import Report

class ResourceLoader {
    
    enum ReportResource: String {
        case fetchResource
    }
    
    static func loadReport(resource: ReportResource) throws -> ReportModel {
        return try loadResource(resource: resource)
    }
    
    static func loadResource<T: Decodable>(resource: ReportResource) throws -> T {
        
        let bundle = Bundle(for: ResourceLoader.self)
        let url = bundle.url(forResource: resource.rawValue, withExtension: "json")
        let data = try Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let fetchNews = try decoder.decode(T.self, from: data)
        
        return fetchNews
    }
}
