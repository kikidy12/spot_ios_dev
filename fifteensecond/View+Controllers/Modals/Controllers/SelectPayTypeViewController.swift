//
//  SelectPayTypeViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/11/05.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SelectPayTypeViewController: UIViewController {
    
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func payEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if sender.view?.tag == 0 {
                
            }
            else if sender.view?.tag == 1 {
                
            }
            else if sender.view?.tag == 2 {
                
            }
            else if sender.view?.tag == 3 {
                
            }
        }
    }
}
