//
//  AdContectViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class AdContectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "광고문의"

        // Do any additional setup after loading the view.
    }

    
    @IBAction func sendMailEvent() {
        UIApplication.shared.open(URL(string: "mailto:cfourworldad@gmail.com")!, options: [:], completionHandler: nil)
    }

}
