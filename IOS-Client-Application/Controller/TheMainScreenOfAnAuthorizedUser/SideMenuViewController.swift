//
//  SideMenuViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Обработчик выбора строки меню
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name("ToggleSideMenu"), object: nil)
        switch indexPath.row {
        case 0:
            NotificationCenter.default.post(name: Notification.Name("ShowProfile"), object: nil)
        default:
            break
        }
    }

}
