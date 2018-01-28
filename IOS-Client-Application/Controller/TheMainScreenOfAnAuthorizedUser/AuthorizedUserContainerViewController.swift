//
//  ContainerViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

class AuthorizedUserContainerViewController: UIViewController {
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var hideSideMenuButton: UIButton!
    @IBOutlet weak var sideMenuConstaint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Событие для открытия меню
        NotificationCenter.default.addObserver(self, selector: #selector(showMenu), name: NSNotification.Name("ShowMenu"), object: nil)
        //Событие для закрытия меню
        NotificationCenter.default.addObserver(self, selector: #selector(hideMenu), name: NSNotification.Name("HideMenu"), object: nil)
    }
    //Нажатие на кнопку закрытия меню
    @IBAction func hideSideMenuButtonClick(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("HideMenu"), object: nil)
    }
    //Свайп влево для закрытия меню
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        NotificationCenter.default.post(name: Notification.Name("HideMenu"), object: nil)
    }
    //Движение от левого края экрана для открытия меню
    @IBAction func leftScreenEdgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        NotificationCenter.default.post(name: Notification.Name("ShowMenu"), object: nil)
    }
    

    //Обработчик события открытия меню
    @objc func showMenu() {
        sideMenuConstaint.constant = 0
        hideSideMenuButton.isHidden = false
        contentContainerView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    //Обработчик события закрытия меню
    @objc func hideMenu() {
        sideMenuConstaint.constant = -240
        contentContainerView.isUserInteractionEnabled = true
        hideSideMenuButton.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}
