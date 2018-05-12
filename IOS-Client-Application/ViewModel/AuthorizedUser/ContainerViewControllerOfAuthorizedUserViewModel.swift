//
//  AuthorizedUserViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 12.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import RxSwift
import RxCocoa

class ContainerViewControllerOfAuthorizedUserViewModel {
    public static let sharedInstance = ContainerViewControllerOfAuthorizedUserViewModel()
    let disposeBag = DisposeBag()
    private var openMenu = BehaviorRelay<Bool>(value: false)
    private var activateOpenMenu = BehaviorRelay<Bool>(value: true)
    public var openMenuObservable: Observable<Bool>?
    
    
    private init(){}
    
    public func setAuthorizedUserViewModel(input: (hideSideMenuButtonTap: Observable<Void>,
        letfSwipe: Observable<UISwipeGestureRecognizer>,
        leftScreenEdgePanGesture: Observable<UIScreenEdgePanGestureRecognizer>)) {
        openMenuObservable = openMenu.asObservable()
        input.letfSwipe.bind{
            _ in
            self.openMenu.accept(false)
        }.disposed(by: disposeBag)
        input.hideSideMenuButtonTap.bind{
            _ in
            self.openMenu.accept(false)
            }.disposed(by: disposeBag)
        input.leftScreenEdgePanGesture.bind{
            _ in
            if(self.activateOpenMenu.value){
                self.openMenu.accept(true)
            }
        }.disposed(by: disposeBag)
    }
    
    public func activateMenu(){
        activateOpenMenu.accept(true)
    }
    
    public func deactivateMenu(){
        activateOpenMenu.accept(false)
    }
    
    public func showMenu(){
        if(self.activateOpenMenu.value){
            self.openMenu.accept(true)
        }
    }
}
