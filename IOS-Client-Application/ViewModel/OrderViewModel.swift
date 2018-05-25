//
//  OrderViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 18.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import RxSwift
import RxCocoa

class OrderViewModel {
    public static let sharedInstance = OrderViewModel()
    private var ordersCount = BehaviorRelay<Int>(value: 0)
    private var ordersArray = Array<Order>()
    private init(){
        
    }
    
    public func createOrder(clientID: Int, typeId: Int, statusId: Int, numberOfAddresses: Int, informationAboutAddresses: String, description: String, cost: Int) -> Observable<Error?>{
        return Observable.create{
            observer in
            Order.createOrder(clientId: clientID, typeID: typeId, statusId: statusId, numberOfAddresses: numberOfAddresses, informationAboutAddresses: informationAboutAddresses, description: description, cost: cost){
                result in
                guard result != nil else {
                    observer.onNext(OrderErrors.CreateOrderError)
                    return
                }
                self.ordersArray.append(result!)
                observer.onNext(nil)
            }
            return Disposables.create()
        }
    }
    
}
