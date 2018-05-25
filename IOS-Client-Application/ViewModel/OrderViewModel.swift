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
    public var ordersArray = Array<Order>()
    public var ordersObservable: Observable<[Order]>!
    
    private init(){
        setModel()
    }
    
    private func setModel(){
        ordersObservable = ordersCount.asObservable()
            .throttle(0.5, scheduler : MainScheduler.instance)
            .share(replay: 1)
            .map{
                _ in
                return self.ordersArray
                
        }
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
                self.ordersCount.accept(self.ordersArray.count)
                observer.onNext(nil)
            }
            return Disposables.create()
        }
    }
    
    public func getAllOrders(userId: Int) {
        ordersCount.accept(0)
        Order.getAllOrdersId(userId: userId) {
            ordersId in
            guard ordersId != nil else {
                return
            }
            for orderId in ordersId! {
                Order.getInformationAboutOrder(id: orderId) {
                    order in
                    guard order != nil else {
                        return
                    }
                    self.ordersArray.append(order!)
                    self.ordersCount.accept(self.ordersArray.count)
                }
            }
        }
    }
}
