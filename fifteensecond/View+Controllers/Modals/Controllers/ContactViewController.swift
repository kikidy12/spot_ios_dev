//
//  ContactViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "고객센터"
    }

    
    @IBAction func callServiceCenterEvent(_ sender: UIButton) {
        self.phoneCall("0269250607")
    }
    
    @IBAction func katalkServiceCenterEvent(_ sender: UIButton) {
        //카톡연결
        UIApplication.shared.open(URL(string: "https://pf.kakao.com/_SClxkT")!, options: [:], completionHandler: nil)
    }
}
