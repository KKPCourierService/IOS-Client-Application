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
    private let userObservable: Observable<User?>
    
    private init(){
        userObservable = user.asObservable()
    }
    

    
    public func login(username: String?, password: String?) -> Observable<Error?> {
        return  Observable.create {
            observer in
            if let username = username, let password = password {
                User.logIn(email: username, password: password){
                    id in
                    guard id != nil else {
                        observer.onNext(Errors.LogInError)
                        return
                    }
                    User.getProfile(id: id!, password: password){
                        user in
                        guard user != nil else {
                            observer.onNext(Errors.LogInError)
                            return
                        }
                        self.user.accept(user)
                        observer.onNext(nil)
                        
                    }
                    
                }
            } else {
                observer.onNext(Errors.LogInError)
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
                            observer.onNext(Errors.CheckInError)
                            return
                        }
                        self.user.accept(user)
                        observer.onNext(nil)
                        
                    }
                } else {
                    observer.onNext(Errors.CheckInError)
                }
                return Disposables.create()
            }
    }
    
    public func logOut() -> Observable<Error?> {
            return  Observable.create {
                    observer in
                    self.user.value?.logOut(){
                        error in
                        guard error != nil else {
                            observer.onNext(Errors.LogOutError)
                            return
                        }
                        observer.onNext(nil)
                }
                return Disposables.create()
            }
            
    }
    
}
