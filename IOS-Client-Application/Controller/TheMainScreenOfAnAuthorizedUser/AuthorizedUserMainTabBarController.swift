//
//  MainTabBarController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

class AuthorizedUserMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    //Нажатие на кнопку открытия меню
    @IBAction func menuBarButtonClick(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
   

}
