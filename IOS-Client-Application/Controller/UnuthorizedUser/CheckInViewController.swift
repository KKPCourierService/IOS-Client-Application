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
    
    
    enum errors : Error {
        case invalidEmail
        case shortPassword
        case thereAreNoDigitsInThePassword
    }
    
    let disposeBag = DisposeBag()
    let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: errors.invalidEmail)
    
    var passwordRules = ValidationRuleSet<String>()
    let minLengthRule = ValidationRuleLength(min: 6, error: errors.shortPassword)
    let digitRule = ValidationRulePattern(pattern: ContainsNumberValidationPattern(), error: errors.thereAreNoDigitsInThePassword)
    
    var emailApproved = false
    var passwordApproved = false
    var passwordConfirmed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        self.surnameTextField.layer.borderColor = UIColor.red.cgColor
        self.surnameTextField.layer.cornerRadius = 6.0
        
        self.nameTextField.layer.borderColor = UIColor.red.cgColor
        self.nameTextField.layer.cornerRadius = 6.0
        
        self.patronymicTextField.layer.borderColor = UIColor.red.cgColor
        self.patronymicTextField.layer.cornerRadius = 6.0
        
        self.phoneNumberTextField.layer.borderColor = UIColor.red.cgColor
        self.phoneNumberTextField.layer.cornerRadius = 6.0
        
        self.emailTextField.layer.borderColor = UIColor.red.cgColor
        self.emailTextField.layer.cornerRadius = 6.0
        
        self.passwordTextField.layer.borderColor = UIColor.red.cgColor
        self.passwordTextField.layer.cornerRadius = 6.0
        
        self.passwordTextField.layer.borderColor = UIColor.red.cgColor
        self.passwordTextField.layer.cornerRadius = 6.0
        
        self.confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
        self.confirmPasswordTextField.layer.cornerRadius = 6.0
        
        passwordRules.add(rule: minLengthRule)
        passwordRules.add(rule: digitRule)
        
        
        surnameTextField.rx.text.orEmpty.skip(1).bind(onNext: {
            [unowned self] in
            if ($0.description.count > 0) {
                self.surnameTextField.layer.borderWidth = 0
            }
            else {
                self.surnameTextField.layer.borderWidth = 1
            }
        }).disposed(by: disposeBag)
        
        nameTextField.rx.text.orEmpty.skip(1).bind(onNext: {
            [unowned self] in
            if ($0.description.count > 0) {
                self.nameTextField.layer.borderWidth = 0
            }
            else {
                self.nameTextField.layer.borderWidth = 1
            }
        }).disposed(by: disposeBag)
        
        patronymicTextField.rx.text.orEmpty.skip(1).bind(onNext: {
            [unowned self] in
            if ($0.description.count > 0) {
                self.patronymicTextField.layer.borderWidth = 0
            }
            else {
                self.patronymicTextField.layer.borderWidth = 1
            }
        }).disposed(by: disposeBag)
        
        phoneNumberTextField.rx.text.orEmpty.skip(1).bind(onNext: {
            [unowned self] in
            if ($0.description.count == 10) {
                self.phoneNumberTextField.layer.borderWidth = 0
            }
            else {
                self.phoneNumberTextField.layer.borderWidth = 1
            }
        }).disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty.skip(1).bind(onNext: {
            [unowned self] in
            switch $0.validate(rule: self.emailRule) {
            case .valid :
                self.emailApproved = true
                self.emailTextField.layer.borderWidth = 0
            case .invalid(_):
                self.emailApproved = false
                self.emailTextField.layer.borderWidth = 1
            }
        }).disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty.skip(1).bind(onNext: {
            [unowned self] in
            switch $0.validate(rules: self.passwordRules) {
            case .valid :
                self.passwordApproved = true
                self.passwordTextField.layer.borderWidth = 0
            case .invalid(_):
                self.passwordApproved = false
                self.passwordTextField.layer.borderWidth = 1
                
            }
            if($0 == self.confirmPasswordTextField.text) {
                 self.confirmPasswordTextField.layer.borderWidth = 0
                 self.passwordConfirmed = true
            } else {
                self.confirmPasswordTextField.layer.borderWidth = 1
                self.passwordConfirmed = false
            }
        }).disposed(by: disposeBag)
        
        confirmPasswordTextField.rx.text.orEmpty.skip(1).bind(onNext: {
            [unowned self] in
            if ($0 == self.passwordTextField.text) {
                self.passwordConfirmed = true
                self.confirmPasswordTextField.layer.borderWidth = 0
            } else {
                self.passwordConfirmed = false
                self.confirmPasswordTextField.layer.borderWidth = 1
            }
        }).disposed(by: disposeBag)
        
        
        
        //Регистрация
        buttonCheckIn.rx.tap.bind {
            [unowned self] in
            if (self.passwordConfirmed && self.passwordApproved && self.emailApproved && !self.surnameTextField.text!.isEmpty
                && !self.nameTextField.text!.isEmpty && !self.patronymicTextField.text!.isEmpty && self.phoneNumberTextField.text!.count == 10) {
                let provider = MoyaProvider<ClientsNetworkService>()
                provider.rx.request(.checkInNewUser(email: self.emailTextField.text!, password: self.passwordTextField.text!, name: self.nameTextField.text!, surname: self.surnameTextField.text!, patronymic: self.patronymicTextField.text!, phoneNumber: "8\(self.phoneNumberTextField.text!)"))
                    .filter(statusCodes: 200...399)
                    .subscribe({
                        response in
                        switch response {
                        case .success(let responseJson):
                            do {
                                let json = try responseJson.mapJSON()
                                if let jsonIdObject = json as? [String: Any] {
                                    let id = (jsonIdObject["clientId"] as? Int)!
                                    provider.rx.request(.getProfile(Id: id))
                                        .filter(statusCodes: 200...399)
                                        .subscribe({
                                            response in
                                            switch response {
                                            case .success(let responseJsonProfile):
                                                do {
                                                    let jsonProfile = try responseJsonProfile.mapJSON()
                                                    if let jsonProfileObject = jsonProfile as? [String: Any] {
                                                        
                                                        let email = (jsonProfileObject["clientEmail"] as? String)!
                                                        let name = (jsonProfileObject["clientName"] as? String)!
                                                        let surname = (jsonProfileObject["clientSurname"] as? String)!
                                                        let patronymic = (jsonProfileObject["clientPatronymic"] as? String)!
                                                        let phoneNumber = (jsonProfileObject["clientPhoneNumber"] as? String)!
                                                        User.user = User.init(id: id, name: name, surname: surname, patronymic: patronymic, email: email, password: self.passwordTextField.text!, phoneNumber: phoneNumber, photoURL: nil)
                                                        self.performSegue(withIdentifier: "FinishCheckIn", sender: self)
                                                        self.navigationController?.popViewController(animated: true)
                                                    }
                                                }
                                                catch {
                                                    self.printExeptionAlert(messageText: "Ошибка регистрации")
                                                }
                                                
                                            case .error(_):
                                                self.printExeptionAlert(messageText: "Ошибка регистрации")
                                            }
                                            }
                                        ).disposed(by: self.disposeBag)
                                }
                            }
                            catch {
                                self.printExeptionAlert(messageText: "Ошибка регистрации")
                            }
                        case .error(_):
                            self.printExeptionAlert(messageText: "Ошибка регистрации")
                        }}
                    ).disposed(by: self.disposeBag)
            }
            else {
                if (!self.passwordApproved) {
                    self.passwordTextField.layer.borderWidth = 1
                }
                if (!self.passwordConfirmed) {
                    self.passwordTextField.layer.borderWidth = 1
                }
                if (!self.emailApproved) {
                    self.emailTextField.layer.borderWidth = 1
                }
                if (self.nameTextField.text!.isEmpty) {
                    self.nameTextField.layer.borderWidth = 1
                }
                if (self.surnameTextField.text!.isEmpty) {
                    self.surnameTextField.layer.borderWidth = 1
                }
                if (self.patronymicTextField.text!.isEmpty) {
                    self.patronymicTextField.layer.borderWidth = 1
                }
                if (self.phoneNumberTextField.text!.count != 10) {
                    self.phoneNumberTextField.layer.borderWidth = 1
                }
                self.printExeptionAlert(messageText: "Не корректно заполнены обязательные поля")
            }
            }.disposed(by: disposeBag)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}