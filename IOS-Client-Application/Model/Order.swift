//
//  Order.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 16.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import RxCocoa
import RxSwift
import Moya

class Order {
    private static let disposeBag = DisposeBag()
    private static let provider = MoyaProvider<OrdersNetworkService>()
    
    private var id: BehaviorRelay<Int>
    private var typeId = BehaviorRelay<Int?>(value: nil)
    private var courierId = BehaviorRelay<Int?>(value: nil)
    private var statusId = BehaviorRelay<Int?>(value: nil)
    private var numberOfAddresses = BehaviorRelay<Int?>(value: nil)
    private var informationAboutAddresses = BehaviorRelay<String?>(value: nil)
    private var description = BehaviorRelay<String?>(value: nil)
    private var cost = BehaviorRelay<Int?>(value: nil)
    
    public var getId: Int{
        get {
            return id.value
        }
    }
    
    public var getOrderType: Int{
        get {
            return typeId.value!
        }
    }
    
    public init(id: Int,
                typeOrder: Int,
                courierId: Int,
                statusId: Int,
                numberOfAddresses: Int,
                informationAboutAddresses: String,
                description: String,
                cost: Int){
        self.id = BehaviorRelay(value: id)
        self.typeId = BehaviorRelay(value: typeOrder)
        self.courierId = BehaviorRelay(value: courierId)
        self.statusId = BehaviorRelay(value: statusId)
        self.numberOfAddresses = BehaviorRelay(value: numberOfAddresses)
        self.informationAboutAddresses = BehaviorRelay(value: informationAboutAddresses)
        self.description = BehaviorRelay(value: description)
        self.cost = BehaviorRelay(value: cost)
    }
    
    public var IdObservable: Observable<Int>{
        get{
            return id.asObservable()
        }
    }
    
    public var TypeIdObservable: Observable<Int?>{
        get {
            return typeId.asObservable()
        }
    }
    
    public var CourierIdObservable: Observable<Int?>{
        get {
            return courierId.asObservable()
        }
    }
    
    public var StatusIdObservable: Observable<Int?>{
        get {
            return statusId.asObservable()
        }
    }
    
    public var NumberOfAddressesObservable: Observable<Int?>{
        get {
            return numberOfAddresses.asObservable()
        }
    }
    
    public var InformationAboutAddressesObservable: Observable<String?> {
        get {
            return informationAboutAddresses.asObservable()
        }
    }
    
    public var DescriptionObservable: Observable<String?>{
        get {
            return description.asObservable()
        }
    }
    
    public var CostObservable: Observable<Int?> {
        get {
            return cost.asObservable()
        }
    }
    
    public static func getAllOrdersId (userId: Int, result:@escaping([Int]?) ->()) {
        provider.rx
            .request(.getAllOrders(clientId: userId))
            .filter(statusCodes: 200...399)
            .subscribe({
                response in
                switch response {
                case .success(let responseJson):
                    do {
                        let json = try responseJson.mapJSON()
                        guard let jsonIdObject = json as? [String: Any] else  {
                            result(nil)
                            return
                        }
                        guard let ordersId = (jsonIdObject["orderId"] as? [Int]) else {
                            result(nil)
                            return
                        }
                        result(ordersId)
                    }
                    catch {
                        result(nil)
                    }
                case .error(_):
                    result(nil)
                }}
            ).disposed(by: disposeBag)
    }
    
    public static func getInformationAboutOrder(id: Int, result:@escaping(Order?)->()){
        provider.rx
            .request(.getOrder(orderId: id))
            .filter(statusCodes: 200...399)
            .subscribe({
                response in
                switch response {
                case .success(let responseJson):
                    do{
                        
                        let json = try responseJson.mapJSON()
                        guard let jsonOrderObject = json as? [String: Any] else {
                            result(nil)
                            return
                        }
                        guard let orderTypeId = (jsonOrderObject["orderTypeId"] as? Int) else {
                            result(nil)
                            return
                        }
                        guard let orderStatusId = (jsonOrderObject["orderStatusId"] as? Int) else {
                            result(nil)
                            return
                        }
                        guard let orderNumberOfAddresses = (jsonOrderObject["orderNumberOfAddresses"] as? Int) else {
                            result(nil)
                            return
                        }
                        guard let orderInformationAboutAddresses = (jsonOrderObject["orderInformationAboutAddresses"] as? String) else {
                            result(nil)
                            return
                        }
                        guard let orderDescription = (jsonOrderObject["orderDescription"] as? String) else {
                            result(nil)
                            return
                        }
                        guard let orderCost = (jsonOrderObject["orderCost"] as? Int) else {
                            result(nil)
                            return
                        }
                       
                        result(Order(id: id, typeOrder: orderTypeId, courierId: 0, statusId: orderStatusId, numberOfAddresses: orderNumberOfAddresses, informationAboutAddresses: orderInformationAboutAddresses, description: orderDescription, cost: orderCost))
                    } catch{
                        result(nil)
                    }
                    result(nil)
                case .error(_):
                    result(nil)
                }
            }).disposed(by: disposeBag)
    }
    
    public static func createOrder(clientId: Int, typeID: Int, statusId: Int, numberOfAddresses: Int, informationAboutAddresses: String, description: String, cost: Int, result:@escaping(Int?) ->()){
        provider.rx
            .request(.createOrder(clientId: clientId, orderType: typeID, orderStatusId: statusId, orderNumberOfAddresses: numberOfAddresses, orderInformationAboutAddresses: informationAboutAddresses, orderDescription: description, orderCost: cost))
            .filter(statusCodes: 200...399)
            .subscribe({
                response in
                switch response{
                case .success(let responseJson):
                    do {
                        let json = try responseJson.mapJSON()
                        guard let jsonIdObject = json as? [String: Any] else {
                            result(nil)
                            return
                        }
                        guard let id = (jsonIdObject["orderId"] as? Int) else {
                            result(nil)
                            return
                        }
                        result(id)
                    }
                    catch {
                        result(nil)
                    }
                case .error(_):
                    result(nil)
                }
            })
            .disposed(by: disposeBag)
    }
}
