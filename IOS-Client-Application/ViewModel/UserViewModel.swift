//
//  UserViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 11.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import Foundation
import RxSwift

class UserViewModel {
    static let sharedInstance = UserViewModel()
    
    var newUser = Variable<User?>(nil)
    let user: Observable<User?>
    private init(){
        user = newUser.asObservable()
    }
    
    
}
