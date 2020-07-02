//
//  ListViewController.swift
//  Report
//
//  Created by HoangNguyen on 7/1/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints
import RxSwift
import RxCocoa
import RxDataSources

class ListViewConroller: UIViewController, UIScrollViewDelegate {
    let viewModel: ListViewModel
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    let disposeBag = DisposeBag()
    
    init(_ viewModel: ListViewModel = ListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view.addSubview(activityIndicatorView)
        tableView.refreshControl = refreshControl
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .lightGray
        setupBinding()
    }
    
    func setupBinding() {
        viewModel.loading.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loadDataTrigger.onNext(())
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: {
                dataObserver.onNext(())
            })
            .disposed(by: disposeBag)
                
        let dataSource = RxTableViewSectionedReloadDataSource<PresentationSection>(configureCell: { (dataSource, tableView, indexPath, item) -> CustomCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomCell.self), for: indexPath) as! CustomCell
            cell.displayItem = item
            return cell
        })
        
        viewModel.collection.observeOn(MainScheduler.instance)
            .map({ c in [PresentationSection(header: "", items: c.items)] })
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
        .disposed(by: disposeBag)
        
//        tableView.rx.reachedBottom
//            .bind(to: viewModel.loadNextTrigger)
//        .disposed(by: disposeBag)
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .systemGray5
        tableView.register(CustomCell.self, forCellReuseIdentifier: String(describing: CustomCell.self))
        
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
}
extension ListViewConroller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
