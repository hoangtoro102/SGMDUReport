//
//  APISettings.swift
//  Report
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation

enum HttpMethod: String {

    case get = "GET"
    case post = "POST"
}

protocol APISetting {

    var httpMethod: HttpMethod { get }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [String: Any] { get }
}

extension APISetting {

    var httpMethod: HttpMethod {
        return .get
    }

    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "data.gov.sg"
    }

    var parameters: [String: Any] {
        return [:]
    }

    func createUrlString() -> String {
        return "\(scheme)://\(host)\(path)"
    }
    
    func createUrlRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        var queryItems: [URLQueryItem] = []

        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            queryItems.append(queryItem)
        }
        components.queryItems = queryItems
        
        if let url = components.url {
            return URLRequest(url: url)
        } else {
            return nil
        }
    }
}
