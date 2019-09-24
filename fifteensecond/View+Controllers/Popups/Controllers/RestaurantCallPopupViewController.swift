//
//  RestaurantCallPopupViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 20/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class RestaurantCallPopupViewController: UIViewController {
    
    var restaurant: RestaurantDatas!

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneLabel.text = restaurant.phoneNum
        nameLabel.text = restaurant.name
    }


    @IBAction func callEvent(_ sender: Any) {
        guard let phone = restaurant.phoneNum else { return }
        self.phoneCall(phone)
    }
}
