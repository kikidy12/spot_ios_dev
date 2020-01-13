//
//  CouponTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/11/04.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import Kingfisher

class CouponTableViewCell: UITableViewCell {
    
    var coupon: CouponDatas!

    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var goodsNameLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        brandImageView.layer.cornerRadius = brandImageView.frame.size.height / 2
        backgroundView?.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(_ data: CouponDatas) {
        coupon = data
        if let str = coupon.brandImgUrl {
            brandImageView.kf.setImage(with: URL(string: str), placeholder: UIImage(named: "placeholderImage"))
        }
        brandNameLabel.text = "\(coupon.brandName ?? "미확인") 기프티콘"
        goodsNameLabel.text = "\(coupon.goodsName ?? "미확인")"
        endDateLabel.text = "유효기간 \(coupon.limitDay.dateToString(formatter: "yyyy년 MM월 dd일"))"
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
