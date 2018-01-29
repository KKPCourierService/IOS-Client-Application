//
//  EditPasswordViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 29.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

class EditPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.viewControllers.remove(at: navigationController!.viewControllers.count - 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func editPasswordButtonClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
