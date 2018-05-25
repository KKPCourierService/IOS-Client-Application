//
//  Errors.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 10.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//



public enum UserErrors : Error{
    case LogInError
    case CheckInError
    case LogOutError
    case EditNameError
}

public enum OrderErrors : Error{
    case GetInformationError
    case CreateOrderError
}
