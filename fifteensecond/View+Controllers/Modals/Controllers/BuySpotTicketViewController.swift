//
//  BuySpotTicketViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 06/10/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class BuySpotTicketViewController: UIViewController {
    
    var count = 0
    
    @IBOutlet weak var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "이용권 구매하기"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }

    @IBAction func pulsEvent() {
        count += 1
        countLabel.text = "\(count)"
    }

    @IBAction func miunsEvent() {
        if count > 1 {
            count -= 1
            countLabel.text = "\(count)"
        }
    }
    
    @IBAction func showPayViewController() {
        let vc = SelectPayTypeViewController()
        vc.count = count
        show(vc, sender: nil)
    }
}
