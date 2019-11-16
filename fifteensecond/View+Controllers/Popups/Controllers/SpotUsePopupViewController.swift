//
//  SpotUsePopupViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 09/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SpotUsePopupViewController: UIViewController {
    
    var useSpotTicket: SpotTicketUseInfoDatas!
    
    var count = 0
    
    var closeHandler: (()->())!
    
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "15Second 이용권\(count)장을\n사용하시겠습니까?"
    }
    
    @IBAction func recordVideo() {
        self.dismiss(animated: true) {
            self.closeHandler()
        }
    }
}
