//
//  ReportService.swift
//  Report
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import RxSwift


protocol ReportServiceProtocol {
    func fetchReportData() -> Observable<ReportModel>
}

class ReportService: ReportServiceProtocol {
    
    func fetchReportData() -> Observable<ReportModel> {
 
        return apiRequest(ReportAPI.fetchReport.createUrlRequest()!)
    }
    
    func apiRequest<T: Decodable>(_ urlRequest: URLRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

                if let _ = error {
                    observer.onError(NetworkResponse.badRequest)
                }
                guard let data = data else {
                    observer.onError(NetworkResponse.noData)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    observer.onError(NetworkResponse.badRequest)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    observer.onNext(result)
                    observer.onCompleted()
                } catch {
                    observer.onError(NetworkResponse.unableToDecode)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

