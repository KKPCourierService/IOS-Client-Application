//
//  ConfirmPasswordViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 29.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

class ConfirmPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func confirmButtonClick(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowEditPassword", sender: self)
    }
    
}
