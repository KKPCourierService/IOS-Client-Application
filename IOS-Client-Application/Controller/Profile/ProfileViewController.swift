//
//  ProfileViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 16.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ProfileViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var patronymicLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let disposeBag = DisposeBag()
    
    private var userViewModel: UserViewModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel = UserViewModel.sharedInstance
        userViewModel.nameObservable?.bind {
            [weak self] value in
            self?.nameLabel.text = value
        }.disposed(by: disposeBag)
        userViewModel.surnameObservable?.bind {
            [weak self] value in
            self?.surnameLabel.text = value
            }.disposed(by: disposeBag)
        userViewModel.patronymicObservable?.bind {
            [weak self] value in
            self?.patronymicLabel.text = value
            }.disposed(by: disposeBag)
        userViewModel.phoneNumberObservable?.bind {
            [weak self] value in
            self?.phoneNumberLabel.text = value
            }.disposed(by: disposeBag)
        userViewModel.emailObservable?.bind {
            [weak self] value in
            self?.emailLabel.text = value
            }.disposed(by: disposeBag)
        userViewModel.passwordObservable?.bind {
            [weak self] value in
            self?.passwordTextField.text = value
            }.disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
