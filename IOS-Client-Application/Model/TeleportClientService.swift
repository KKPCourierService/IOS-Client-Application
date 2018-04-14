//
//  TeleportClientService.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 22.02.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import Foundation
import Moya
enum TeleportClientService {
    case registrationNewClient(clientEmail: String, clientPassword: String, clientName: String, clientSurname: String, clientPatronymic: String, clientPhoneNumber: String)

}


extension TeleportClientService: TargetType {
    var baseURL: URL { return URL(string: "https://kkpcourier.herokuapp.com/")! }
    
    var path: String {
        switch self {
        case .registrationNewClient(_, _, _, _, _, _):
            return "/clients/registrationNewClient"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .registrationNewClient:
            return .post
        }
      
    }
    var task: Task {
        switch self {
        case let .registrationNewClient(clientEmail, clientPassword, clientName, clientSurname, clientPatronymic, clientPhoneNumber):
            return .requestParameters(parameters: ["clientEmail": clientEmail, "clientPassword": clientPassword, "clientName": clientName, "clientSurname": clientSurname, "clientPatronymic": clientPatronymic, "clientPhoneNumber": clientPhoneNumber], encoding: JSONEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
        
        case .registrationNewClient(_, _, _, _, _, _):
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    

    
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}


