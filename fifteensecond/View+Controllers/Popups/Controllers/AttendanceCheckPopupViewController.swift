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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
