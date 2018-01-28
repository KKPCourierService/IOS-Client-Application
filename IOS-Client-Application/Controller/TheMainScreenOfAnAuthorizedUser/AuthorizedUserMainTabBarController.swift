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
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        //Событие перехода на форму профиля
        NotificationCenter.default.addObserver(self, selector: #selector(showProfile), name: NSNotification.Name("ShowProfile"), object: nil)
    }


    //Нажатие на кнопку открытия меню
    @IBAction func menuBarButtonClick(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("ShowMenu"), object: nil)
    }
    
    //Обработчик события перехода на форму профиля
    @objc func showProfile () {
        performSegue(withIdentifier: "ShowProfile", sender: nil)
    }
   

}
