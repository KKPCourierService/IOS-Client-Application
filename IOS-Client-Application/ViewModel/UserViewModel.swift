//
//  UserViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 11.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserViewModel {
    static let sharedInstance = UserViewModel()
    
    var newUser = BehaviorRelay<User?>(value: nil)
    
    let userObservable: Observable<User?>
    
    private init(){
        userObservable = newUser.asObservable()
    }
}
