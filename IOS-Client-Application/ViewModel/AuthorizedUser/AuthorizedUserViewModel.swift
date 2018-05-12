//
//  AuthorizedUserViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 12.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import RxSwift
import RxCocoa

class AuthorizedUserViewModel {
    public static let sharedInstance = AuthorizedUserViewModel()
    private var openMenu = BehaviorRelay<Bool>(value: false)
    public var openMenuObservable: Observable<Bool>?
    let disposeBag = DisposeBag()
    
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
            self.openMenu.accept(true)
        }.disposed(by: disposeBag)
    }
}
