//
//  EditNameViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 30.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditNameViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var editButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    private var editNameViewModel: EditNameViewModel!
    
    
    private var nameObservable: Observable<String> {
        return name.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }

    private var editButtonObservable: Observable<Void> {
        return self.editButton.rx.tap.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModelView()
        self.editNameViewModel
            .editObservable
            .bind{
                [weak self] error in
                if(error == nil) {
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    self?.printExeptionAlert(messageText: "Ошибка при изменении имени")
                }
            }.disposed(by: disposeBag)
        
        self.editNameViewModel
            .editEnabled
            .bind{
                [weak self] valid  in
                self?.editButton.isEnabled = valid
                self?.editButton.alpha = valid ? 1 : 0.5
            }.disposed(by: disposeBag)
    }
    
    
    private func setupModelView() {
        self.editNameViewModel = EditNameViewModel(input: (name: nameObservable, editTap: editButtonObservable))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}
