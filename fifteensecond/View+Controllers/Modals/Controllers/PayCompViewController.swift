//
//  PayCompViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 03/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class PayCompViewController: UIViewController {
    
    var preVC: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showSpotTicketListEvent() {
        dismiss(animated: true) {
            guard let preVC = self.preVC else { return }
            preVC.show(SpotTicketListViewController(), sender: nil)
        }
    }
    
    

}
