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

class ListViewConroller: UIViewController {
    let viewModel: ListViewModel
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    var tableView: UITableView!
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
        setupBinding()
    }
    
    func setupBinding() {
        
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        tableView.backgroundColor = .systemGray5
        tableView.register(CustomCell.self, forCellReuseIdentifier: String(describing: CustomCell.self))
        
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
}
