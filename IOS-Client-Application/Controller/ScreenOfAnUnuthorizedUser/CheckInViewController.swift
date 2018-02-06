//
//  CheckInViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 17.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RxSwift

class CheckInViewController: UIViewController {
    
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var PatronymicTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
    }
    
    @IBAction func checkInButtonClick(_ sender: UIButton) {
        
        performSegue(withIdentifier: "FinishCheckIn", sender: self)
        navigationController?.popViewController(animated: true)
    }
}
