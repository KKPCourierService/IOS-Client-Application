//
//  CheckInViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 11.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//


import RxSwift
import Validator

class CheckInViewModel {
    
    enum errors : Error {
        case invalidEmail
        case shortPassword
        case thereAreNoDigitsInThePassword
    }
    

    
    private let validatedSurname: Observable<Bool>
    private let validatedName: Observable<Bool>
    private let validatePatronymic: Observable<Bool>
    private let validatedPhoneNumber: Observable<Bool>
    private let validatedEmail: Observable<Bool>
    private let validatedPassword: Observable<Bool>
    private let validatedConfirmPassword: Observable<Bool>
    let checkInEnabled: Observable<Bool>
    let checkInObservable: Observable<Error?>
    
    init(input: (surname: Observable<String>,
        name: Observable<String>,
        patronymic: Observable<String>,
        phoneNumber: Observable<String>,
        email: Observable<String>,
        password: Observable<String>,
        confirmPassword: Observable<String>,
        checkInTap: Observable<Void>)) {
        

        
        self.validatedSurname = input.surname
            .map{ $0.count > 0}
            .share(replay: 1)
        self.validatedName = input.name
            .map{ $0.count > 0}
            .share(replay: 1)
        self.validatePatronymic = input.patronymic
            .map{ $0.count > 0}
            .share(replay: 1)
        self.validatedPhoneNumber = input.phoneNumber
            .map{ $0.count == 10}
            .share(replay: 1)
        self.validatedEmail = input.email
            .map{
                let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: errors.invalidEmail)
                switch $0.validate(rule: emailRule) {
                case .valid :
                    return true
                case .invalid(_):
                    return false
                }}
            .share(replay: 1)
        
        self.validatedPassword = input.password
            .map{
                var passwordRules = ValidationRuleSet<String>()
                let minLengthRule = ValidationRuleLength(min: 6, error: errors.shortPassword)
                let digitRule = ValidationRulePattern(pattern: ContainsNumberValidationPattern(), error: errors.thereAreNoDigitsInThePassword)
                passwordRules.add(rule: minLengthRule)
                passwordRules.add(rule: digitRule)
                
                switch $0.validate(rules: passwordRules) {
                case .valid :
                    return true
                case .invalid(_):
                    return false
                }
            }
            .share(replay: 1)
        
        
        self.validatedConfirmPassword = Observable.combineLatest(input.password, input.confirmPassword) { $0.elementsEqual($1)}
        
        self.checkInEnabled = Observable.combineLatest(validatedSurname, validatedName, validatePatronymic, validatedPhoneNumber,
                                                       validatedEmail, validatedPassword, validatedConfirmPassword) { $0 && $1 && $2 && $3 && $4 && $5 && $6 }
        
        let userProfile = Observable.combineLatest(input.surname, input.name, input.patronymic, input.phoneNumber, input.email, input.password) {($0, $1, $2, $3, $4, $5)}
        
        self.checkInObservable = input.checkInTap.withLatestFrom(userProfile).flatMapLatest{ (surname, name, patronymic, phoneNumber, email, password) in
            return UserViewModel.sharedInstance.checkIn(surname: surname, name: name, patronymic: patronymic, phoneNumber: phoneNumber, email: email, password: password).observeOn(MainScheduler.instance)
        }
    }
}
