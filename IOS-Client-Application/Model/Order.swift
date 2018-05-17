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
    private var cost = BehaviorRelay<Double?>(value: nil)
    
    public init(id: Int){
        self.id = BehaviorRelay(value: id)
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
    
    public var CostObservable: Observable<Double?> {
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
    
    public func getInformationAboutOrder(result:@escaping(Error?)->()){
        let disposeBag = DisposeBag()
        let provider = MoyaProvider<OrdersNetworkService>()
        
        provider.rx
            .request(.getOrder(orderId: self.id.value))
            .filter(statusCodes: 200...399)
            .subscribe({
                response in
                switch response {
                case .success(let responseJson):
                    do{
                        let json = try responseJson.mapJSON()
                        guard let jsonOrderObject = json as? [String: Any] else {
                            result(OrderErrors.GetInformationError)
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
                        guard let orderCost = (jsonOrderObject["orderCost"] as? Double) else {
                            result(nil)
                            return
                        }
                        self.typeId.accept(orderTypeId)
                        self.statusId.accept(orderStatusId)
                        self.numberOfAddresses.accept(orderNumberOfAddresses)
                        self.informationAboutAddresses.accept(orderInformationAboutAddresses)
                        self.description.accept(orderDescription)
                        self.cost.accept(orderCost)
                        result(nil)
                    } catch{
                        result(OrderErrors.GetInformationError)
                    }
                    result(nil)
                case .error(_):
                    result(OrderErrors.GetInformationError)
                }
            }).disposed(by: disposeBag)
        
    }
}
