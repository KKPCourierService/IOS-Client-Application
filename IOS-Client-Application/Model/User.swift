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
    private var _id: Int
    private var _name: String
    private var _surname: String
    private var _patronymic: String
    private var _email: String
    private var _password: String
    private var _phoneNumber: String
    private var _photoURL: String?
    public static var user : User?
    
    //Инициализатор класса User
    public init (id: Int, name: String, surname: String, patronymic: String, email: String, password: String, phoneNumber: String, photoURL: String?) {
        _id = id
        _name = name
        _surname = surname
        _patronymic = patronymic
        _email = email
        _password = password
        _phoneNumber = phoneNumber
        _photoURL = photoURL
    }
    
    //Свойство класса для получения идентификатора пользователя
    public var Id : Int {
        get {
            return _id
        }
    }
    //Свойство класса для получения имени пользователя
    public var Name: String {
        get {
            return _name
        }
    }
    
    //Свойство класса для получения фамилии пользователя
    public var Surname: String {
        get {
            return _surname
        }
    }
    
    //Свойство класса для получения отчества пользователя
    public var Patronymic: String {
        get {
            return _patronymic
        }
    }
    
    //Свойство класса для получения email пользователя
    public var Email: String {
        get {
            return _email
        }
    }
    
    //Свойство класса для получения номера телефона пользователя
    public var PhoneNumber: String {
        get {
            return _phoneNumber
        }
    }
    
    //Свойство класса для получения ссылки на фото профиля пользователя
    public var PhotoURL: String? {
        get {
            return _photoURL
        }
    }
}
