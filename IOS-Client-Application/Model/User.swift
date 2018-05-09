//
//  User.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import Foundation
import Alamofire



public class User {
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
}
