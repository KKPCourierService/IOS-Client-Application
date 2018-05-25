//
//  ClientsNetworkService.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 16.04.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//


import Moya

enum ClientsNetworkService {
    case checkInNewUser(email: String, password: String, name: String, surname: String, patronymic: String, phoneNumber: String)
    case logIn(email: String, password: String)
    case getProfile(Id: Int)
    case logOut()
    case editName(id: Int, name: String)
    case editSurname(id: Int, surname: String)
    case editPatronymic(id: Int, patronymic: String)
}


extension ClientsNetworkService: TargetType {
    var baseURL: URL { return URL(string: "https://kkpcourier.herokuapp.com")! }
    var path: String {
        switch self {
        case .checkInNewUser:
            return "/clients/signUpClient"
        case .logIn:
            return "/clients/login"
        case .getProfile(let Id):
            return "/clients/\(Id)/profile"
        case .logOut:
            return "/clients/logout"
        case .editName(let id, _):
            return "/clients/\(id)/profile/editName"
        case .editSurname(let id, _):
            return "/clients/\(id)/profile/editSurname"
        case .editPatronymic(let id, _):
            return "/clients/\(id)/profile/editPatronymic"
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .checkInNewUser, .logIn, .logOut, .editName, .editSurname, .editPatronymic:
            return .post
        case .getProfile:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .checkInNewUser(email, password, name, surname, patronymic, phoneNumber): 
            return .requestParameters(parameters: ["clientEmail": email, "clientPassword": password, "clientName": name,"clientSurname": surname, "clientPatronymic": patronymic, "clientPhoneNumber": phoneNumber], encoding: JSONEncoding.default)
        case let .logIn(email, password):
            return .requestParameters(parameters: ["clientEmail": email, "clientPassword": password], encoding: JSONEncoding.default)
        case let .editName(_, name):
            return .requestParameters(parameters: ["clientName":  name], encoding: JSONEncoding.default)
        case let .editSurname(_, surname):
            return .requestParameters(parameters: ["clientSurname":  surname], encoding: JSONEncoding.default)
        case let .editPatronymic(_, patronymic):
            return .requestParameters(parameters: ["clientPatronymic":  patronymic], encoding: JSONEncoding.default)
        case .getProfile(_), .logOut:
            return .requestPlain
        }
       
    }
    
    var sampleData: Data {
        switch self {
        case .checkInNewUser, .logIn(_, _), .getProfile, .logOut, .editName(_, _), .editSurname(_, _), .editPatronymic:
            return  "".data(using: .ascii)!
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
