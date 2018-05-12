//
//  LogInViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 17.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Validator


class LogInViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var authorizationButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let disposeBag = DisposeBag()
    
    private var logInViewModel: LogInViewModel!
    
    
    private var usernameObservable: Observable<String> {
        return loginTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    private var passwordObservable: Observable<String> {
        return passwordTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    private var loginButtonObservable: Observable<Void> {
        return self.authorizationButton.rx.tap.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModelView()
        self.logInViewModel
            .loginObservable
            .bind{
                [weak self] error in
                if(error == nil) {
                    self?.loginTextField.text = ""
                    self?.passwordTextField.text = ""
                    self?.performSegue(withIdentifier: "FinishLogIn", sender: self)
                } else {
                    self?.printExeptionAlert(messageText: "Ошибка авторизации")
                }
            }.disposed(by: disposeBag)
        
        self.logInViewModel
            .loginEnabled
            .bind{
                [weak self] valid  in
                self?.authorizationButton.isEnabled = valid
                self?.authorizationButton.alpha = valid ? 1 : 0.5
            }.disposed(by: disposeBag)
    }
    
    
    private func setupModelView() {
        self.logInViewModel = LogInViewModel(input: (username: self.usernameObservable,
                                                password: self.passwordObservable,
                                                loginTap: self.loginButtonObservable))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
