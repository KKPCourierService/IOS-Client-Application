//
//  EditSurnameViewModel.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 26.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import RxSwift
import RxCocoa

class EditSurnameViewModel {
    
    private let validateSurname: Observable<Bool>
    let editEnabled: Observable<Bool>
    let editObservable: Observable<Error?>
    
    init(input: (surname: Observable<String>,
        editTap: Observable<Void>)) {
        self.validateSurname = input.surname
            .map { $0.count > 0 }
            .share(replay: 1)
        self.editEnabled = self.validateSurname
        
        self.editObservable = input.editTap.withLatestFrom(input.surname).flatMapLatest{ surname in
            return UserViewModel.sharedInstance.editSurname(surname: surname).observeOn(MainScheduler.instance)
        }
    }
}
