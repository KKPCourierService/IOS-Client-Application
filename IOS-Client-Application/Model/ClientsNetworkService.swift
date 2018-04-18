//
//  ClientsNetworkService.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 16.04.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import Foundation
import Moya

enum ClientsNetworkService {
    case checkInNewUser(email: String, password: String, name: String, surname: String, patronymic: String, phoneNumber: String)
    case logIn(email: String, password: String)
}


extension ClientsNetworkService: TargetType {
    var baseURL: URL { return URL(string: "https://kkpcourier.herokuapp.com")! }
    var path: String {
        switch self {
        case .checkInNewUser:
            return "/clients/signUpClient"
        case .logIn:
            return "/clients/logIn"
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .checkInNewUser, .logIn:
            return .post
        }
    }
    var task: Task {
        switch self {
        case let .checkInNewUser(email, password, name, surname, patronymic, phoneNumber): 
            return .requestParameters(parameters: ["clientEmail": email, "clientPassword": password, "clientName": name,"clientSurname": surname, "clientPatronymic": patronymic, "clientPhoneNumber": phoneNumber], encoding: JSONEncoding.default)
        case let .logIn(email, password):
            return .requestParameters(parameters: ["clientEmail": email, "courierPassword": password], encoding: JSONEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .checkInNewUser, .logIn(_, _):
            return  "Half measures are as bad as nothing at all.".data(using: .ascii)!
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
