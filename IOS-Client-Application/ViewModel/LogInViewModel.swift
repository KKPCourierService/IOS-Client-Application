//
//  LogInViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 09.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import Foundation
import RxSwift

class LogInViewModel {
    
    let validatedEmail: Observable<Bool>
    let validatedPassword: Observable<Bool>
    let loginEnabled: Observable<Bool>
    let loginObservable: Observable<Error?>
    
    init(input: (username: Observable<String>,
        password: Observable<String>,
        loginTap: Observable<Void>)) {
        
        self.validatedEmail = input.username
            .map { $0.count >= 5 }
            .share(replay: 1)
        
        self.validatedPassword = input.password
            .map { $0.count >= 4 }
            .share(replay: 1)
        
        self.loginEnabled = Observable.combineLatest(validatedEmail, validatedPassword ) { $0 && $1 }
        let userAndPassword = Observable.combineLatest(input.username, input.password) {($0,$1)}
        
        self.loginObservable = input.loginTap.withLatestFrom(userAndPassword).flatMapLatest{ (username, password) in
            return LogInViewModel.login(username: username, password: password).observeOn(MainScheduler.instance)
        }
    }
    
    private class func login(username: String?, password: String?) -> Observable<Error?> {
        return  Observable.create { observer in
            if let username = username, let password = password {
                User.logIn(email: username, password: password){
                    id, error in
                    if(id != nil){
                        User.getProfile(id: id!, password: password){
                            user, error in
                            let userViewModel = UserViewModel.sharedInstance
                            userViewModel.newUser.accept(user)
                            observer.onNext(nil)
                        }
                    } else {
                        observer.onNext(Errors.LogInError)
                    }
                }
            } else {
                observer.onNext(Errors.LogInError)
            }
            return Disposables.create()
        }
    }
}