//
//  AttendanceCheckPopupViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class AttendanceCheckPopupViewController: UIViewController {
    
    var count = 0
    
    @IBOutlet weak var attendenceCoutLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attendenceCoutLabel.text = "\(count)/10"
    }


}
