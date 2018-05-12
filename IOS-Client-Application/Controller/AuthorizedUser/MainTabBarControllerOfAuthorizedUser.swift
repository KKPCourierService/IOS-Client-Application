//
//  MainTabBarController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

class MainTabBarControllerOfAuthorizedUser: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        ContainerViewControllerOfAuthorizedUserViewModel.sharedInstance.activateMenu()
    }
    
    //Нажатие на кнопку открытия меню
    @IBAction func menuBarButtonClick(_ sender: UIBarButtonItem) {
        ContainerViewControllerOfAuthorizedUserViewModel.sharedInstance.showMenu()
    }
}
