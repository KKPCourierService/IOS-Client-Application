//
//  UIViewControllerExtension.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 20.04.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

extension UIViewController {
    func printExeptionAlert (messageText : String) {
        let alert = UIAlertController(title: "Ошибка", message: messageText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
