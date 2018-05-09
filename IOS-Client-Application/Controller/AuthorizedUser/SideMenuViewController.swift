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
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = "\(User.user!.Surname) \(User.user!.Name)"
    }
    
    //Обработчик выбора строки меню
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name("HideMenu"), object: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            NotificationCenter.default.post(name: Notification.Name("ShowProfile"), object: nil)
        case 2:
            let provider = MoyaProvider<ClientsNetworkService>()
            provider.rx.request(.logOut())
                .filter(statusCodes: 200...399)
                .subscribe({
                    response in
                    switch response {
                    case .success(_):
                        NotificationCenter.default.post(name: Notification.Name("LogOut"), object: nil)
                    case .error(_):
                        self.printExeptionAlert(messageText: "Не возможно выйти из профиля")
                    }
                    }
                ).disposed(by: self.disposeBag)
            
        default:
            break
        }
    }
    

}
