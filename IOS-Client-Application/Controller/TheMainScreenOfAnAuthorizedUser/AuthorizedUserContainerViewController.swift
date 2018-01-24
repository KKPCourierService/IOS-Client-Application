//
//  ContainerViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

class AuthorizedUserContainerViewController: UIViewController {
    
    @IBOutlet weak var sideMenuConstaint: NSLayoutConstraint!
    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Событие
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
        // Do any additional setup after loading the view.
    }

    
    //Обработчик события открытия меню
    @objc func toggleSideMenu() {
        if sideMenuOpen {
            sideMenuConstaint.constant = -240
            sideMenuOpen = false
        } else {
            sideMenuConstaint.constant = 0
            sideMenuOpen = true
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

}
