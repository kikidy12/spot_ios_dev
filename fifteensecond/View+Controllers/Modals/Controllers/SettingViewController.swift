//
//  SettingViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumLabel.text = "\(GlobalDatas.currentUser.nationalCode ?? "82")\(GlobalDatas.currentUser.phoneNum ?? "")"
        emailLabel.text = GlobalDatas.currentUser.email
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "환경설정"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }

}
