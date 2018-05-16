//
//  CreateOrderViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 16.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CreateOrderViewController: UIViewController {
    @IBOutlet weak var orderTypeSegmentController: UISegmentedControl!
    @IBOutlet weak var whenceTextField: UITextField!
    @IBOutlet weak var whereTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var createOrderButton: UIButton!
    
    private var createOrderViewModel: CreateOrderViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCreateOrderViewModel()
        createOrderViewModel.createOrderEnabled
            .bind{
                [weak self] valid in
                self?.createOrderButton.isEnabled = valid
                self?.createOrderButton.alpha = valid ? 1 : 0.5
        }.disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func setupCreateOrderViewModel() {
        self.createOrderViewModel = CreateOrderViewModel.init(input: (
            typeOrder: orderTypeObservable,
            whenceAdress: whenceObservable,
            whereAdress: whereObservable,
            descriptionOrder: descriptionObservable,
            cost: costObservable,
            createTap: createButtonObservable))
    }
    private var orderTypeObservable: Observable<Int> {
        return orderTypeSegmentController.rx.selectedSegmentIndex.asObservable()
    }
    
    private var whenceObservable: Observable<String> {
        return whenceTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    private var whereObservable: Observable<String> {
        return whereTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    
    private var descriptionObservable: Observable<String> {
        return descriptionTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    
    private var costObservable: Observable<String> {
        return costTextField.rx.text.throttle(0.5, scheduler : MainScheduler.instance).map(){ text in
            return text ?? ""
        }
    }
    
    private var createButtonObservable: Observable<Void>{
        return createOrderButton.rx.tap.asObservable()
    }

}
