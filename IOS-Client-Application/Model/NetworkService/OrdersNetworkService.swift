//
//  OrdersNetworkService.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 16.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import Moya

enum OrdersNetworkService {
    case getAllOrders(clientId: Int)
    case getOrder(orderId: Int)
    case createOrder(clientId: Int, orderType: Int, orderStatusId: Int, orderNumberOfAddresses: Int,
        orderInformationAboutAddresses: String, orderDescription: String, orderCost: Double)
    
}


extension OrdersNetworkService: TargetType {
    var baseURL: URL { return URL(string: "https://kkpcourier.herokuapp.com")! }
    var path: String {
        switch self {
        case .getAllOrders(let clientId):
            return "/clients/\(clientId)/orders"
        case .getOrder(let orderId):
            return "/orders/\(orderId)"
        case .createOrder(let clientId):
            return "/clients/\(clientId)/orders/create"
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .getAllOrders, .getOrder:
            return .get
        case .createOrder:
            return .post
        }
    }
    var task: Task {
        switch self {
            
        case let .createOrder(clientId, orderType, orderStatusId, orderNumberOfAddresses, orderInformationAboutAddresses, orderDescription, orderCost):
            return .requestParameters(parameters: ["orderTypeId": orderType, "clientId": clientId, "orderStatusId": orderStatusId, "orderNumberOfAddresses": orderNumberOfAddresses, "orderInformationAboutAddresses": orderInformationAboutAddresses, "orderDescription": orderDescription, "orderCost": orderCost], encoding: JSONEncoding.default)
        case .getAllOrders(_), .getOrder(_):
            return .requestPlain
        }
        
    }
    
    var sampleData: Data {
        switch self {
        case .getAllOrders(_), .getOrder(_), .createOrder(_,_,_,_,_,_,_):
            return  "".data(using: .ascii)!
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
