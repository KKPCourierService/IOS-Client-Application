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
import Validator
import Moya

class CheckInViewController: UIViewController {
    
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var patronymicTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var buttonCheckIn: UIButton!
    
    
    let disposeBag = DisposeBag()
    
    private var viewModel: CheckInViewModel!
    
    
    private var surnameObservable: Observable<String> {
        return surnameTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    
    
    private var nameObservable: Observable<String> {
        return nameTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    
    private var patronymicObservable: Observable<String> {
        return patronymicTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    
    private var phoneNumberObservable: Observable<String> {
        return phoneNumberTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    
    private var emailObservable: Observable<String> {
        return emailTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    
    private var passwordObservable: Observable<String> {
        return passwordTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    private var confirmPasswordObservable: Observable<String> {
        return confirmPasswordTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    

    private var checkInButtonObservable: Observable<Void> {
        return self.buttonCheckIn.rx.tap.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModelView()
        
        self.viewModel.checkInObservable.bind{ user, error in
            if(user == nil) {
                self.printExeptionAlert(messageText: "Ошибка регистрации")
            } else {
                User.user = user
                self.performSegue(withIdentifier: "FinishCheckIn", sender: self)
                self.navigationController?.popViewController(animated: true)
            }
            }.disposed(by: disposeBag)
        
        self.viewModel.checkInEnabled.bind{ valid  in
            self.buttonCheckIn.isEnabled = valid
            self.buttonCheckIn.alpha = valid ? 1 : 0.5
            }.disposed(by: disposeBag)
    }
    
 
    private func setupModelView() {
        self.viewModel = CheckInViewModel(input: (surname: self.surnameObservable, name: nameObservable, patronymic: patronymicObservable, phoneNumber: phoneNumberObservable, email: emailObservable, password: passwordObservable, confirmPassword: confirmPasswordObservable, checkInTap: checkInButtonObservable))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        surnameTextField.text = ""
        nameTextField.text = ""
        passwordTextField.text = ""
        phoneNumberTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
}
