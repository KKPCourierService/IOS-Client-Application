//
//  User.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa



public class User {
    
    private static let disposeBag = DisposeBag()
    private static let provider = MoyaProvider<ClientsNetworkService>()
    
    private var id: BehaviorRelay<Int>
    private var name: BehaviorRelay<String>
    private var surname: BehaviorRelay<String>
    private var patronymic: BehaviorRelay<String>
    private var email: BehaviorRelay<String>
    private var password: BehaviorRelay<String>
    private var phoneNumber: BehaviorRelay<String>
  
    
    
    public init (id: Int, name: String, surname: String, patronymic: String, email: String,
                 password: String, phoneNumber: String) {
        self.id = BehaviorRelay(value: id)
        self.name = BehaviorRelay(value: name)
        self.surname = BehaviorRelay(value: surname)
        self.patronymic = BehaviorRelay(value: patronymic)
        self.email = BehaviorRelay(value: email)
        self.password = BehaviorRelay(value: password)
        self.phoneNumber = BehaviorRelay(value: phoneNumber)
    }
    
    
    public var IdObservable : Observable<Int> {
        get {
            return id.asObservable()
        }
    }
    
    public var NameObservable: Observable<String> {
        get {
            return name.asObservable()
        }
    }
    
    
    public var SurnameObservable: Observable<String> {
        get {
            return surname.asObservable()
        }
    }
    
    
    public var PatronymicObservable: Observable<String> {
        get {
            return patronymic.asObservable()
        }
    }
    
    public var EmailObservable: Observable<String> {
        get {
            return email.asObservable()
        }
    }
    
    
    public var PhoneNumberObservable: Observable<String> {
        get {
            return phoneNumber.asObservable()
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
                                         email: email, password: password, phoneNumber: phoneNumber))
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
                                    password: password, phoneNumber: phoneNumber))
                        
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
    
    
    public func logOut(result:@escaping(Error?) ->()) {
        let provider = MoyaProvider<ClientsNetworkService>()
        let disposeBag = DisposeBag()
        provider.rx.request(.logOut())
            .filter(statusCodes: 200...399)
            .subscribe({
                response in
                switch response {
                case .success(_):
                    result(nil)
                case .error(_):
                    result(Errors.LogOutError)
                }
                }
            ).disposed(by: disposeBag)
    }
}
