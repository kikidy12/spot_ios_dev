//
//  CouponsViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 06/10/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class CouponsViewController: UIViewController {
    
    var couponList = [CouponDatas]() {
        didSet {
            if couponList.isEmpty {
                emptyCouponView.isHidden = false
            }
            else {
                emptyCouponView.isHidden = true
            }
            
            couponTableView.reloadData()
        }
    }
    
    @IBOutlet weak var hasTicketCountLabel: UILabel!
    @IBOutlet weak var couponTableView: UITableView!
    @IBOutlet weak var emptyCouponView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        couponTableView.delegate = self
        couponTableView.dataSource = self
        couponTableView.register(UINib(nibName: "CouponTableViewCell", bundle: nil), forCellReuseIdentifier: "couponCell")
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
        AlertHandler().showAlert(vc: self, message: "서비스 준비중입니다.", okTitle: "확인")
//        let vc = BuySpotTicketViewController()
//        show(vc, sender: nil)
    }
    
    @IBAction func showCheckSpotCodeViewEvent() {
        AlertHandler().showAlert(vc: self, message: "서비스 준비중입니다.", okTitle: "확인")
//        let vc = CheckSpotCodeViewController()
//        show(vc, sender: nil)
    }
}

extension CouponsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "couponCell", for: indexPath) as! CouponTableViewCell
        
        cell.initView(couponList[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getCouponDetail(coupon: couponList[indexPath.item])
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
            
            self.getCouponList()
        }
    }
    
    func getCouponList() {
        ServerUtil.shared.getMyCoupon(self) { (success, dict, message) in
            guard success, let array = dict?["roullete"] as? NSArray else {
                return
            }
            
            self.couponList = array.compactMap { CouponDatas($0 as! NSDictionary)}
            
        }
    }
    
    func getCouponDetail(coupon: CouponDatas) {
        guard let id = coupon.id else {
            return
        }
        let parameters = [
            "roulette_winning_log_id": id
        ] as [String:Any]
        ServerUtil.shared.postMyCoupon(self, parameters: parameters) { (success, dict, message) in
            guard success, let data = dict?["roullete"] as? NSDictionary  else {
                return
            }
            
            let coupon = CouponDatas(data)
            
            if coupon.status == "PAY" {
                let vc = CouponDetailViewController()
                vc.coupon = coupon
                self.show(vc, sender: nil)
            }
            else {
                AlertHandler.shared.showAlert(vc: self, message: "사용불가능한 쿠폰입니다.", okTitle: "확인")
            }
        }
    }
}
