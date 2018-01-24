//
//  User.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import Foundation
import Alamofire

class User {
    private var _id: Int?
    private var _name: String
    private var _surname: String
    private var _patronymic: String
    private var _email: String
    private var _password: String
    private var _phoneNumber: String
    private var _photoURL: String?
    
    private init (id: Int, name: String, surname: String, patronymic: String, email: String, password: String, phoneNumber: String, photoURL: String?) {
        _id = id
        _name = name
        _surname = surname
        _patronymic = patronymic
        _email = email
        _password = password
        _phoneNumber = phoneNumber
        _photoURL = photoURL
    }
}
