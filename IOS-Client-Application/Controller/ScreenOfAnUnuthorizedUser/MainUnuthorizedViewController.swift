//
//  MainViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 17.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

class MainUnuthorizedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
 

}
