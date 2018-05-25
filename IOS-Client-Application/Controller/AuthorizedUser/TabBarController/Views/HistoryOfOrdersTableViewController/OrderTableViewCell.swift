//
//  OrderTableViewCell.swift
//  IOS-Client-Application
//
//  Created by Игорь Коршунов on 25.05.2018.
//  Copyright © 2018 Игорь Коршунов. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var typeId: UILabel!
    @IBOutlet weak var informationAboutAdressis: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var descriptionOrder: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    public var order: Order?{
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        if order != nil {
            orderId.text = "\(String(order!.getId))"
            switch order!.getOrderType {
            case 1:
                typeId.text = "Обычная доставка"
            case 2:
                typeId.text = "Срочная доставка"
            default:
                typeId.text = ""
            }
            informationAboutAdressis.text = "\(order!.getInformationAboutAddresses)"
            status.text = "Невыполняется"
            descriptionOrder.text = "\(order!.getDescription)"
            cost.text = "\(order!.getCost) рублей"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
