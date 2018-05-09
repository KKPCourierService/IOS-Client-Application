//
//  AuthorizationViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 17.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Validator
import Moya


class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var authorizationButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationButton.rx.tap.bind { [unowned self] in
            let provider = MoyaProvider<ClientsNetworkService>()
            provider.rx.request(.logIn(email: self.loginTextField.text!, password: self.passwordTextField.text!))
                .filter(statusCodes: 200...399)
                .subscribe({
                    response in
                    switch response {
                    case .success(let responseJson):
                        do {
                            let json = try responseJson.mapJSON()
                            if let jsonIdObject = json as? [String: Any] {
                                let id = (jsonIdObject["clientId"] as? Int)!
                                provider.rx.request(.getProfile(Id: id))
                                    .filter(statusCodes: 200...399)
                                    .subscribe({
                                        response in
                                        switch response {
                                        case .success(let responseJsonProfile):
                                            do {
                                                let jsonProfile = try responseJsonProfile.mapJSON()
                                                if let jsonProfileObject = jsonProfile as? [String: Any] {
                                                    
                                                    let email = (jsonProfileObject["clientEmail"] as? String)!
                                                    let name = (jsonProfileObject["clientName"] as? String)!
                                                    let surname = (jsonProfileObject["clientSurname"] as? String)!
                                                    let patronymic = (jsonProfileObject["clientPatronymic"] as? String)!
                                                    let phoneNumber = (jsonProfileObject["clientPhoneNumber"] as? String)!
                                                    User.user = User.init(id: id, name: name, surname: surname, patronymic: patronymic, email: email, password: self.passwordTextField.text!, phoneNumber: phoneNumber, photoURL: nil)
                                                    self.performSegue(withIdentifier: "FinishLogIn", sender: self)
                                                    self.navigationController?.popViewController(animated: true)
                                                }
                                            }
                                            catch {
                                                self.printExeptionAlert(messageText: "Ошибка авторизации")
                                            }
                                            
                                        case .error(_):
                                            self.printExeptionAlert(messageText: "Ошибка авторизации")
                                        }
                                        }
                                    ).disposed(by: self.disposeBag)
                            }
                        }
                        catch {
                            self.printExeptionAlert(messageText: "Ошибка авторизации")
                        }
                    case .error(_):
                        self.printExeptionAlert(messageText: "Ошибка авторизации")
                    }}
                ).disposed(by: self.disposeBag)
            }.disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    
}
