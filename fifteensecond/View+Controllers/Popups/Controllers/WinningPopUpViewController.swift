//
//  WinningPopUpViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 16/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class WinningPopUpViewController: UIViewController {
    
    @IBOutlet weak var winningImageView: UIImageView!
    @IBOutlet weak var winningLabel: UILabel!
    
    var compClouser: (()->())!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func closeView() {
        self.dismiss(animated: true) {
            self.compClouser()
        }
    }

}
