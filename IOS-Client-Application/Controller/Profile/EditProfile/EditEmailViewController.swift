//
//  EditEmailViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 30.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

class EditEmailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func editEmailButtonClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
