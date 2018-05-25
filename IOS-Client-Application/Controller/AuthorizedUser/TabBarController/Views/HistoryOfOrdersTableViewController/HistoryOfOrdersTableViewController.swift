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

class HistoryOfOrdersTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var ordersViewModel: OrderViewModel!
    private let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersViewModel = OrderViewModel.sharedInstance
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        ordersViewModel.ordersObservable.subscribe{
            _ in
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersViewModel.ordersArray.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        if let order = cell as? OrderTableViewCell {
            order.order = ordersViewModel.ordersArray[indexPath.row]
        }
        return cell
    }
 
}
