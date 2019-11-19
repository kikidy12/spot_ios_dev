//
//  BuySpotTicketViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 06/10/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class BuySpotTicketViewController: UIViewController {
    
    var count = 1
    
    @IBOutlet weak var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text = "\(count)"
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
        guard count != 0 else {
            return
        }
        AlertHandler.shared.showAlert(vc: self, message: "스팟 \(count)장\n구매하시겠습니까?", okTitle: "구매하기", cancelTitle: "취소", okHandler: { (_) in
            let vc = SelectPayTypeViewController()
            GlobalDatas.spotTicketBuyDict["count"] = self.count
            self.show(vc, sender: nil)
        })
    }
}
