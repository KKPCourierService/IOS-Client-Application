//
//  UserViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 11.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import RxSwift
import RxCocoa

class UserViewModel {
    static let sharedInstance = UserViewModel()
    
    private var user = BehaviorRelay<User?>(value: nil)
    private let disposeBag = DisposeBag()
    private let userObservable: Observable<User?>
    
    
    
    public var idObservable: Observable<Int>?
    public var nameObservable: Observable<String>?
    public var surnameObservable: Observable<String>?
    public var patronymicObservable: Observable<String>?
    public var emailObservable: Observable<String>?
    public var passwordObservable: Observable<String>?
    public var phoneNumberObservable: Observable<String>?
    
    
    private init(){
        userObservable = user.asObservable()
        userObservable.bind{
            value in
            guard value == nil else {
                self.idObservable = value?.IdObservable
                self.nameObservable = value?.NameObservable
                self.surnameObservable = value?.SurnameObservable
                self.patronymicObservable = value?.PatronymicObservable
                self.emailObservable = value?.EmailObservable
                self.passwordObservable = value?.PasswordObservable
                self.phoneNumberObservable = value?.PhoneNumberObservable
                return
            }
            self.idObservable = nil
            self.nameObservable = nil
            self.surnameObservable = nil
            self.patronymicObservable = nil
            self.emailObservable = nil
            self.passwordObservable = nil
            self.phoneNumberObservable = nil
            }.disposed(by: disposeBag)
    }
    
    
    public var getUserId: Int {
        get{
            return self.user.value!.GetId
        }
    }
    
    public func login(username: String?, password: String?) -> Observable<Error?> {
        return  Observable.create {
            observer in
            if let username = username, let password = password {
                User.logIn(email: username, password: password){
                    id in
                    guard id != nil else {
                        observer.onNext(UserErrors.LogInError)
                        return
                    }
                    User.getProfile(id: id!, password: password){
                        user in
                        guard user != nil else {
                            observer.onNext(UserErrors.LogInError)
                            return
                        }
                        self.user.accept(user)
                        observer.onNext(nil)
                        
                    }
                }
            } else {
                observer.onNext(UserErrors.LogInError)
            }
            return Disposables.create()
        }
    }
    
    public func checkIn(surname: String?, name: String?, patronymic: String?, phoneNumber: String?, email: String?, password: String?)
        -> Observable<Error?> {
            return  Observable.create { observer in
                if let email = email, let password = password {
                    User.checkIn(surname: surname!, name: name!, patronymic: patronymic!, phoneNumber: phoneNumber!, email: email, password: password){
                        user in
                        guard user != nil else {
                            observer.onNext(UserErrors.CheckInError)
                            return
                        }
                        self.user.accept(user)
                        observer.onNext(nil)
                        
                    }
                } else {
                    observer.onNext(UserErrors.CheckInError)
                }
                return Disposables.create()
            }
    }
    
    public func logOut() {
        self.user.value!.logOut(){
            error in
            guard error == nil else {
                return
            }
            self.user.accept(nil)
        }
    }
    
    public func editName(name: String)
        -> Observable<Error?> {
            return  Observable.create { observer in
                self.user.value!.editName(name: name){
                    vvvv in
                    guard vvvv != nil else {
                        observer.onNext(nil)
                        return
                    }
                    observer.onNext(UserErrors.EditNameError)
                }
                return Disposables.create()
            }
    }
}
