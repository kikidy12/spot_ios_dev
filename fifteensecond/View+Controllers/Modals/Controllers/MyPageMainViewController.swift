//
//  MyPageMainViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class MyPageMainViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = GlobalDatas.currentUser.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "My Page"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @IBAction func showUseListVCEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.show(UseListViewController(), sender: nil)
        }
    }
    
    @IBAction func showCouponListVCEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
//            self.show(UseListViewController(), sender: nil)
        }
    }
    
    @IBAction func showAttandVCEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.showPopupView(vc: AttendanceCheckViewController())
        }
    }
    
    @IBAction func showNoticeListVCEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.show(NoticeListViewController(), sender: nil)
        }
    }
    
    @IBAction func showAdVCEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.show(AdContectViewController(), sender: nil)
        }
    }
    
    @IBAction func showContractVCEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.show(ContactViewController(), sender: nil)
        }
    }
    
    @IBAction func showSettingVCEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.show(SettingViewController(), sender: nil)
        }
    }

}
