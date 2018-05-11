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
    
    private var viewModel: LogInViewModel!
    
    
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
        
        self.viewModel.loginObservable.bind{
            [weak self] user, error in
            if(user == nil) {
                self?.printExeptionAlert(messageText: "Ошибка авторизации")
            } else {
                self?.loginTextField.text = ""
                self?.passwordTextField.text = ""
                let userViewModel = UserViewModel.sharedInstance
                userViewModel.newUser.accept(user)
                self?.performSegue(withIdentifier: "FinishLogIn", sender: self)
            }
            }.disposed(by: disposeBag)
        
        self.viewModel.loginEnabled.bind{
            [weak self] valid  in
            self?.authorizationButton.isEnabled = valid
            self?.authorizationButton.alpha = valid ? 1 : 0.5
            }.disposed(by: disposeBag)
    }
    

    private func setupModelView() {
        self.viewModel = LogInViewModel(input: (username: self.usernameObservable,
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
