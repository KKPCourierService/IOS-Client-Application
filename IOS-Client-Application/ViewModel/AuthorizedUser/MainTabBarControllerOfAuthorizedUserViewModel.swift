//
//  MainTabBarControllerOfAuthorizedUserViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 13.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//


import RxSwift
import RxCocoa

class MainTabBarControllerOfAuthorizedUserViewModel{
    public static let sharedInstance = MainTabBarControllerOfAuthorizedUserViewModel()
    private let segueBehaviorRelay = BehaviorRelay<Bool>(value: false)
    public let showProfileObservable: Observable<Bool>
    
    init(){
        showProfileObservable = segueBehaviorRelay.asObservable()
    }
    
    public func showProfile(){
        segueBehaviorRelay.accept(true)
        segueBehaviorRelay.accept(false)
        ContainerViewControllerOfAuthorizedUserViewModel.sharedInstance.deactivateMenu()
    }
}
