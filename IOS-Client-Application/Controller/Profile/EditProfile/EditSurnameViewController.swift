//
//  EditSurnameViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 30.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class EditSurnameViewController: UIViewController {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var surname: UITextField!
    let disposeBag = DisposeBag()
    
    private var editSurnameViewModel: EditSurnameViewModel!
    
    
    private var surnameObservable: Observable<String> {
        return surname.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    
    private var editButtonObservable: Observable<Void> {
        return self.editButton.rx.tap.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModelView()
        self.editSurnameViewModel
            .editObservable
            .bind{
                [weak self] error in
                if(error == nil) {
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    self?.printExeptionAlert(messageText: "Ошибка при изменении фамилии")
                }
            }.disposed(by: disposeBag)
        
        self.editSurnameViewModel
            .editEnabled
            .bind{
                [weak self] valid  in
                self?.editButton.isEnabled = valid
                self?.editButton.alpha = valid ? 1 : 0.5
            }.disposed(by: disposeBag)
    }
    
    
    private func setupModelView() {
        self.editSurnameViewModel = EditSurnameViewModel(input: (surname: surnameObservable, editTap: editButtonObservable))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}
