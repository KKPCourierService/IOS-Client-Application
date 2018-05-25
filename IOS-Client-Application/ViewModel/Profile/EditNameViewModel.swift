//
//  EditNameViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 26.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import RxSwift
import RxCocoa

class EditNameViewModel {
    
    private let validateName: Observable<Bool>
    let editEnabled: Observable<Bool>
    let editObservable: Observable<Error?>
    
    init(input: (name: Observable<String>,
        editTap: Observable<Void>)) {
        self.validateName = input.name
            .map { $0.count > 0 }
            .share(replay: 1)
        self.editEnabled = self.validateName
       
        self.editObservable = input.editTap.withLatestFrom(input.name).flatMapLatest{ name in
            return UserViewModel.sharedInstance.editName(name: name).observeOn(MainScheduler.instance)
        }
    }
}
