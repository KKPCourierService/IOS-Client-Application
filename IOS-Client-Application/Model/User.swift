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
    
    
    public init (id: Int, name: String, surname: String, patronymic: String, email: String,
                 password: String, phoneNumber: String, photoURL: String?) {
        self.id = id
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.photoURL = photoURL
    }
    
    
    public var Id : Int {
        get {
            return id
        }
    }
    
    public var Name: String {
        get {
            return name
        }
    }
    
    
    public var Surname: String {
        get {
            return surname
        }
    }
    
    
    public var Patronymic: String {
        get {
            return patronymic
        }
    }
    
    
    public var Email: String {
        get {
            return email
        }
    }
    
    
    public var PhoneNumber: String {
        get {
            return phoneNumber
        }
    }
    
    
    public var PhotoURL: String? {
        get {
            return photoURL
        }
    }
    
    
    public static func logIn (email: String, password: String, result:@escaping(Int?) ->()) {
        provider.rx
            .request(.logIn(email: email, password: password))
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
                        guard let id = (jsonIdObject["clientId"] as? Int) else {
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
                }}
            ).disposed(by: disposeBag)
    }
    
    
    public static func checkIn (surname: String, name: String, patronymic: String, phoneNumber: String,
                                email: String, password: String, result:@escaping(User?) ->()) {
        provider.rx
            .request(.checkInNewUser(email: email, password: password, name: name, surname: surname,
                                     patronymic: patronymic, phoneNumber: "8\(phoneNumber)"))
            .filter(statusCodes: 200...399)
            .subscribe({
                response in
                switch response {
                case .success(let responseJson):
                    do {
                        let json = try responseJson.mapJSON()
                        guard let jsonIdObject = json as? [String: Any] else {
                            result(nil)
                            return
                        }
                        guard let id = (jsonIdObject["clientId"] as? Int) else {
                            result(nil)
                            return
                        }
                        result(User.init(id: id, name: name, surname: surname, patronymic: patronymic,
                                         email: email, password: password, phoneNumber: phoneNumber, photoURL: nil))
                    }
                    catch {
                        result(nil)
                    }
                case .error(_):
                    result(nil)
                }}
            ).disposed(by: self.disposeBag)
    }
    
    
    public static func getProfile (id: Int, password: String, result:@escaping(User?) ->()) {
        provider.rx.request(.getProfile(Id: id))
            .filter(statusCodes: 200...399)
            .subscribe({
                response in
                switch response {
                case .success(let responseJsonProfile):
                    do {
                        let jsonProfile = try responseJsonProfile.mapJSON()
                        guard let jsonProfileObject = jsonProfile as? [String: Any] else {
                            result(nil)
                            return
                        }
                        guard let email = (jsonProfileObject["clientEmail"] as? String) else {
                            result(nil)
                            return
                        }
                        guard let name = (jsonProfileObject["clientName"] as? String) else {
                            result(nil)
                            return
                        }
                        guard let surname = (jsonProfileObject["clientSurname"] as? String) else {
                            result(nil)
                            return
                        }
                        guard let patronymic = (jsonProfileObject["clientPatronymic"] as? String) else {
                            result(nil)
                            return
                        }
                        guard let phoneNumber = (jsonProfileObject["clientPhoneNumber"] as? String) else {
                            result(nil)
                            return
                        }
                        result(User(id: id, name: name, surname: surname, patronymic: patronymic, email: email,
                                    password: password, phoneNumber: phoneNumber, photoURL: nil))
                        
                    }
                    catch {
                        result(nil)
                    }
                    
                case .error(_):
                    result(nil)
                }
                }
            ).disposed(by: disposeBag)
        
    }
}
