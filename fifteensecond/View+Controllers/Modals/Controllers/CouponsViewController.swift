//
//  CouponsViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 06/10/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class CouponsViewController: UIViewController {
    
    var couponList = [String]()
    
    @IBOutlet weak var hasTicketCountLabel: UILabel!
    @IBOutlet weak var couponTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        couponTableView.delegate = self
        couponTableView.dataSource = self
        couponTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.01))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "이용권 사용하기"
        getUserInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @IBAction func showBuyTicketView() {
        let vc = BuySpotTicketViewController()
        show(vc, sender: nil)
    }
    
    @IBAction func showCheckSpotCodeViewEvent() {
        let vc = CheckSpotCodeViewController()
        show(vc, sender: nil)
    }
}

extension CouponsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    
}

extension CouponsViewController {
    
    func getUserInfo() {
        let parameters = [
            "os": "iOS",
            "device_token": GlobalDatas.deviceToken
        ] as [String:Any]
        
        ServerUtil.shared.getInfo(self, parameters: parameters) { (success, dict, message) in
            guard success, let isAttend = dict?["today_attendance"] as? Bool,
                let user = dict?["user"] as? NSDictionary else { return }
            
            GlobalDatas.currentUser = UserData(user, isAttend: isAttend)
            
            self.hasTicketCountLabel.text = "\(GlobalDatas.currentUser.ticketCount ?? 0)장"
        }
    }
    
}
