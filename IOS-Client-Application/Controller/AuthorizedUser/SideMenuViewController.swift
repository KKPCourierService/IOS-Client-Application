//
//  SideMenuViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class SideMenuViewController: UITableViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    
    let disposeBag = DisposeBag()
    let userViewModel = UserViewModel.sharedInstance
    var userNameAndSurname: Observable<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameAndSurname = Observable.combineLatest(userViewModel.nameObservable!, userViewModel.surnameObservable!) {
            "\($0) \($1)"
        }
        userNameAndSurname?.bind{
            [weak self] value in
            self?.userNameLabel.text = "\(value)"
            }.disposed(by: disposeBag)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            MainTabBarControllerOfAuthorizedUserViewModel.sharedInstance.showProfile()
        case 2:
            ContainerViewControllerOfAuthorizedUserViewModel.sharedInstance.logOut()
        default:
            break
        }
    }
    
    
}
