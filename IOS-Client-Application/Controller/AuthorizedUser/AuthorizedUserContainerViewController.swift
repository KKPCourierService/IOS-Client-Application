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
    @IBOutlet weak var leftScreenEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Событие для открытия меню
        NotificationCenter.default.addObserver(self, selector: #selector(showMenu), name: Notification.Name("ShowMenu"), object: nil)
        //Событие для закрытия меню
        NotificationCenter.default.addObserver(self, selector: #selector(hideMenu), name: Notification.Name("HideMenu"), object: nil)
        //Событие выхода из аккаунта
        NotificationCenter.default.addObserver(self, selector: #selector(logOut), name: Notification.Name("LogOut"), object: nil)
        //Событие отключения меню
        NotificationCenter.default.addObserver(self, selector: #selector(disableSideMenu), name: Notification.Name("DisableSideMenu"), object: nil)
        //Событие включения меню
        NotificationCenter.default.addObserver(self, selector: #selector(enableSideMenu), name: Notification.Name("EnableSideMenu"), object: nil)
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
    
    
    //Обработчик выхода из аккаунта
    @objc func logOut() {
        let user = UserViewModel.sharedInstance
        user.newUser.accept(nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    //Обработчик включения меню
    @objc func enableSideMenu() {
        leftScreenEdgePanGesture.isEnabled = true
    }
    
    
    //Обработчик отключения меню
    @objc func disableSideMenu() {
        leftScreenEdgePanGesture.isEnabled = false
    }
}
