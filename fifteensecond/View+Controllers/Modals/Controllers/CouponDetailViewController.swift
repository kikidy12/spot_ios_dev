//
//  CouponDetailViewController.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/11/03.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class CouponDetailViewController: UIViewController {
    
    var coupon: CouponDatas!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var barcodeImageView: UIImageView!
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var storeName2Label: UILabel!
    @IBOutlet weak var issueDateLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productImageView.kf.setImage(with: setImageView(urlStr: coupon.goodsImgUrl))
        barcodeImageView.kf.setImage(with: setImageView(urlStr: coupon.barcodeUrl))
        
        storeNameLabel.text = "\(coupon.brandName ?? "미확인")"
        storeName2Label.text = "\(coupon.brandName ?? "미확인")"
        productNameLabel.text = "\(coupon.goodsName ?? "미확인")"
        endDateLabel.text = coupon.limitDay.dateToString(formatter: "yyyy년 MM월 dd일")
        issueDateLabel.text = coupon.reciveDate.dateToString(formatter: "yyyy년 MM월 dd일")
        if coupon.status == "PAY" {
            stateLabel.text = "사용가능"
        }
        else {
            stateLabel.text = "사용불가"
        }
        detailLabel.text = "\(coupon.content ?? "상품 설명이 없습니다.")"
    }
    
    func setImageView(urlStr: String?) -> URL? {
        if let urlStr = urlStr, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            return url
        }
        else {
            return nil
        }
    }

}
