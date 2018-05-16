//
//  CreateOrderViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 16.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import RxSwift
import RxCocoa

class CreateOrderViewModel {
    private let validatedWhenceAdress: Observable<Bool>
    private let validatedWhereAdress: Observable<Bool>
    private let validatedDescription: Observable<Bool>
    private let validatedCost: Observable<Bool>
    let createOrderEnabled: Observable<Bool>
    
    init(input:(typeOrder: Observable<Int>,
        whenceAdress: Observable<String>,
        whereAdress: Observable<String>,
        descriptionOrder: Observable<String>,
        cost: Observable<String>,
        createTap: Observable<Void>)) {
        self.validatedWhenceAdress = input.whenceAdress
            .map{$0.count>0}
            .share(replay: 1)
        self.validatedWhereAdress = input.whereAdress
            .map{$0.count>0}
            .share(replay: 1)
        self.validatedDescription = input.descriptionOrder
            .map{$0.count>0}
            .share(replay: 1)
        self.validatedCost = input.cost
            .map{$0.count>2}
            .share(replay: 1)
        self.createOrderEnabled = Observable.combineLatest(validatedCost, validatedDescription, validatedWhereAdress, validatedWhenceAdress)
        {$0 && $1 && $2 && $3}
        
    }
    
    
    
    
    /*  let userAndPassword = Observable.combineLatest(input.username, input.password) {($0,$1)}
     
     self.loginObservable = input.loginTap.withLatestFrom(userAndPassword).flatMapLatest{ (username, password) in
     return UserViewModel.sharedInstance.login(username: username, password: password).observeOn(MainScheduler.instance)*/
    
}
