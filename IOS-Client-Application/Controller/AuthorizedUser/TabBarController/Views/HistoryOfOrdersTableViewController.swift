//
//  HistoryOfOrdersTableViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 25.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryOfOrdersTableViewController: UITableViewController {
    private var ordersViewController: OrderViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        ordersViewController = OrderViewModel.sharedInstance
        
        ordersViewController.ordersObservable
            .bind{
                value in
            }.disposed(by: disposeBag)
    }
}
