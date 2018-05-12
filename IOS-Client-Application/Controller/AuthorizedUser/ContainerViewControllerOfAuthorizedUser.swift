//
//  ContainerViewController.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 24.01.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ContainerViewControllerOfAuthorizedUser: UIViewController {
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var hideSideMenuButton: UIButton!
    @IBOutlet weak var sideMenuConstaint: NSLayoutConstraint!
    @IBOutlet weak var leftScreenEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var leftSwipe: UISwipeGestureRecognizer!
    
    private var authorizedUserViewModel: ContainerViewControllerOfAuthorizedUserViewModel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModelView()
        self.authorizedUserViewModel
            .openMenuObservable!
            .skip(1)
            .subscribe{
                [weak self] value in
                self?.contentContainerView.isUserInteractionEnabled = !value.element!
                self?.hideSideMenuButton.isHidden = !value.element!
                if value.element! {
                    self?.sideMenuConstaint.constant = 0
                    
                } else {
                    self?.sideMenuConstaint.constant = -240
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self?.view?.layoutIfNeeded()
                })
                
            }.disposed(by: disposeBag)
    }
    
    private var leftSwipeObservable: Observable<UISwipeGestureRecognizer> {
        return self.leftSwipe.rx.event.asObservable()
    }
    
    private var leftScreenEdgePanGestureObservable: Observable<UIScreenEdgePanGestureRecognizer> {
        return self.leftScreenEdgePanGesture.rx.event.asObservable()
    }
    
    private var hideSideMenuTapObservable: Observable<Void> {
        return self.hideSideMenuButton.rx.tap.asObservable()
    }
    
    private func setupModelView() {
        self.authorizedUserViewModel = ContainerViewControllerOfAuthorizedUserViewModel.sharedInstance
        authorizedUserViewModel.setAuthorizedUserViewModel(input: (
            hideSideMenuButtonTap: self.hideSideMenuTapObservable,
            letfSwipe: self.leftSwipeObservable,
            leftScreenEdgePanGesture: self.leftScreenEdgePanGestureObservable))
    }
    
    
    
    @objc func logOut() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
