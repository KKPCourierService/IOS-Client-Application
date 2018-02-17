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
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        passwordRules.add(rule: minLengthRule)
        passwordRules.add(rule: digitRule)
        
        emailTextField.rx.text.orEmpty.bind(onNext: { [unowned self] in
            switch $0.validate(rule: self.emailRule) {
            case .valid :
                self.emailApproved = true
            case .invalid(_):
                self.emailApproved = false
            }
        }).disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty.bind(onNext: { [unowned self] in
            switch $0.validate(rules: self.passwordRules) {
            case .valid :
                self.passwordApproved = true
            case .invalid(_):
                self.passwordApproved = false
            }
            if($0 == self.confirmPasswordTextField.text) {
                self.passwordConfirmed = true
            } else {
                self.passwordConfirmed = false
            }
        }).disposed(by: disposeBag)
        
        confirmPasswordTextField.rx.text.orEmpty.bind(onNext: { [unowned self] in
            if ($0 == self.passwordTextField.text) {
                self.passwordConfirmed = true
            } else {
                self.passwordConfirmed = false
            }
        }).disposed(by: disposeBag)
        
        buttonCheckIn.rx.tap.bind { [unowned self] in
            if (self.passwordConfirmed && self.passwordApproved && self.emailApproved && !self.surnameTextField.text!.isEmpty
                && !self.nameTextField.text!.isEmpty && !self.patronymicTextField.text!.isEmpty && !self.phoneNumberTextField.text!.isEmpty) {
                self.performSegue(withIdentifier: "FinishCheckIn", sender: self)
                self.navigationController?.popViewController(animated: true)
            }
            }.disposed(by: disposeBag)
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
    
    
    
}
