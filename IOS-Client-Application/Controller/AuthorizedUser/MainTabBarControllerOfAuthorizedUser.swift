//
//  MainTabBarController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainTabBarControllerOfAuthorizedUser: UITabBarController {
    
    private var viewModel = MainTabBarControllerOfAuthorizedUserViewModel.sharedInstance
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showProfileObservable
            .subscribe{
                [weak self] value in
                if (value.element!) {
                    self?.performSegue(withIdentifier: "ShowProfile", sender: nil)
                }
            }.disposed(by: disposeBag)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        ContainerViewControllerOfAuthorizedUserViewModel.sharedInstance.activateMenu()
        
    }
    
    
    @IBAction func menuBarButtonClick(_ sender: UIBarButtonItem) {
        ContainerViewControllerOfAuthorizedUserViewModel.sharedInstance.showMenu()
    }
}
