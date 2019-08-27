//
//  BuyTicketPopupViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 20/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class BuyTicketPopupViewController: UIViewController {
    
    var ticket: TicketDatas!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var sellerURLLabel: UILabel!
    @IBOutlet weak var sellerImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = ticket.name
        
    }
    
    @IBAction func goToSeller() {
        
    }
}
