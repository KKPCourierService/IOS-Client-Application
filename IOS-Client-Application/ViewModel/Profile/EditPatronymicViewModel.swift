//
//  EditPatronymicViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 26.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//


import RxCocoa
import RxSwift

class EditPatronymicViewModel {
    private let validatePatronymic: Observable<Bool>
    let editEnabled: Observable<Bool>
    let editObservable: Observable<Error?>
    
    init(input: (patronymic: Observable<String>,
        editTap: Observable<Void>)) {
        self.validatePatronymic = input.patronymic
            .map { $0.count > 0 }
            .share(replay: 1)
        self.editEnabled = self.validatePatronymic
        
        self.editObservable = input.editTap.withLatestFrom(input.patronymic).flatMapLatest{ patronymic in
            return UserViewModel.sharedInstance.editPatronymic(patronymic: patronymic).observeOn(MainScheduler.instance)
        }
    }
}
