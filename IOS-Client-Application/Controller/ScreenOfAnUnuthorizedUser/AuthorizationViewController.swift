//
//  AuthorizationViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 17.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Validator

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var authorizationButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationButton.rx.tap.bind { [unowned self] in
            self.performSegue(withIdentifier: "FinishAuthorization", sender: self)
            }.disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTextField.text = ""
        passwordTextField.text = ""
    }
}
