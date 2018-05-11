//
//  User.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import Foundation
import Moya
import RxSwift



public class User {
    
    private static let disposeBag = DisposeBag()
    private static let provider = MoyaProvider<ClientsNetworkService>()
    
    private var id: Int
    private var name: String
    private var surname: String
    private var patronymic: String
    private var email: String
    private var password: String
    private var phoneNumber: String
    private var photoURL: String?
    public static var user : User?
    
    //Инициализатор класса User
    public init (id: Int, name: String, surname: String, patronymic: String, email: String, password: String, phoneNumber: String, photoURL: String?) {
        self.id = id
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.photoURL = photoURL
    }
    
    //Свойство класса для получения идентификатора пользователя
    public var Id : Int {
        get {
            return id
        }
    }
    //Свойство класса для получения имени пользователя
    public var Name: String {
        get {
            return name
        }
    }
    
    //Свойство класса для получения фамилии пользователя
    public var Surname: String {
        get {
            return surname
        }
    }
    
    //Свойство класса для получения отчества пользователя
    public var Patronymic: String {
        get {
            return patronymic
        }
    }
    
    //Свойство класса для получения email пользователя
    public var Email: String {
        get {
            return email
        }
    }
    
    //Свойство класса для получения номера телефона пользователя
    public var PhoneNumber: String {
        get {
            return phoneNumber
        }
    }
    
    //Свойство класса для получения ссылки на фото профиля пользователя
    public var PhotoURL: String? {
        get {
            return photoURL
        }
    }
    
    public static func logIn (email: String, password: String, result:@escaping(Int?, Errors) ->()) {
        provider.rx.request(.logIn(email: email, password: password))
            .filter(statusCodes: 200...399)
            .subscribe({
                response in
                switch response {
                case .success(let responseJson):
                    do {
                        let json = try responseJson.mapJSON()
                        if let jsonIdObject = json as? [String: Any] {
                            let id = (jsonIdObject["clientId"] as? Int)!
                            result(id, Errors.LogInError)
                        }
                    }
                    catch {
                        result(nil, Errors.LogInError)
                    }
                case .error(_):
                    result(nil, Errors.LogInError)
                }}
            ).disposed(by: disposeBag)
    }
    
    public static func getProfile (id: Int, password: String, result:@escaping(User?, Errors) ->()) {
        provider.rx.request(.getProfile(Id: id))
            .filter(statusCodes: 200...399)
            .subscribe({
                response in
                switch response {
                case .success(let responseJsonProfile):
                    do {
                        let jsonProfile = try responseJsonProfile.mapJSON()
                        if let jsonProfileObject = jsonProfile as? [String: Any] {
                            let email = (jsonProfileObject["clientEmail"] as? String)!
                            let name = (jsonProfileObject["clientName"] as? String)!
                            let surname = (jsonProfileObject["clientSurname"] as? String)!
                            let patronymic = (jsonProfileObject["clientPatronymic"] as? String)!
                            let phoneNumber = (jsonProfileObject["clientPhoneNumber"] as? String)!
                            result(User.init(id: id, name: name, surname: surname, patronymic: patronymic, email: email, password: password, phoneNumber: phoneNumber, photoURL: nil), Errors.LogInError)
                        }
                    }
                    catch {
                        result(nil, Errors.LogInError)
                    }
                    
                case .error(_):
                    result(nil, Errors.LogInError)
                }
                }
            ).disposed(by: disposeBag)
        
    }
}
