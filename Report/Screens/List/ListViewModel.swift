//
//  ListViewModel.swift
//  Report
//
//  Created by HoangNguyen on 7/1/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import RxSwift

final class ListViewModel {
    
    var service: ReportServiceProtocol
    
    let collection = BehaviorSubject<DisplayItemCollection>(value: DisplayItemCollection())
    
    let loading: Observable<Bool>
    var loadDataTrigger: PublishSubject<Void>
//    var loadNextTrigger: PublishSubject<Void>
    let disposeBag = DisposeBag()
    var loadingIndicator: ActivityIndicator!
        
    private let error = PublishSubject<Swift.Error>()
    
    init(_ service: ReportServiceProtocol = ReportService()) {
        loadingIndicator = ActivityIndicator()
        loading = loadingIndicator.asObservable()
        loadDataTrigger = PublishSubject()
//        loadNextTrigger = PublishSubject()
        self.service = service
        load()
    }

    func load() {

        dataObserver.subscribe(onNext: {
            print("Refresh data ListViewModel")
            }).disposed(by: disposeBag)
        
        let loadRequest = self.loading
            .sample(self.loadDataTrigger)
            .flatMap { [weak self] loading -> Observable<DisplayItemCollection> in
                guard let self = self else { fatalError() }
                if loading {
                    return Observable.empty()
                } else {
                    self.collection.onNext(DisplayItemCollection())
                    let report = self.service.fetchReportData()
                    
                    let cll = report.map({ r in DisplayItemCollection(report: r) })
                    
                    return cll.trackActivity(self.loadingIndicator)
                }
        }
        let request = Observable.of(loadRequest)
            .merge()
            .share(replay: 1)

        let response = request
            .flatMapLatest { news -> Observable<DisplayItemCollection> in
            request
                .do(onError: { _error in
                    self.error.onNext(_error)
                }).catchError({ error ->
                    Observable<DisplayItemCollection> in
                    Observable.empty()
                })
            }
        .share(replay: 1)
        
        Observable
            .combineLatest(request, response , collection.asObservable()) { request, response, news in
                return response
        }
        .sample(response)
        .bind(to: collection)
        .disposed(by: disposeBag)
    }
}
