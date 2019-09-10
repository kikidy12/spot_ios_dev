//
//  RestaurantMenuTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 19/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class RestaurantMenuTableViewCell: UITableViewCell {
    
    var numberFormatter = NumberFormatter()
    
    var menu: RestaurantMenuDatas!

    @IBOutlet weak var mainBtn: CustomButton!
    
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var discountPercentLabel: UILabel!
    @IBOutlet weak var cancelLineView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func initView(_ data: RestaurantMenuDatas) {
        numberFormatter.numberStyle = .decimal
        menu = data
        nameLabel.text = menu.name
        menu.isMain ? (mainBtn.isHidden = false) : (mainBtn.isHidden = true)
        salePriceLabel.text = "\(numberFormatter.string(for: menu.price) ?? "0")원"
        priceLabel.text = "\(menu.price ?? 0)원"
        
        if let rate = menu.discountRate {
            cancelLineView.isHidden = false
            arrowLabel.isHidden = false
            var discountPrice = 0
            if let price = menu.price, price > 0 {
                discountPrice = price - Int(Double(price * rate) / 100)
            }
            discountPercentLabel.text = "\(rate)%"
            salePriceLabel.text = "\(numberFormatter.string(for: discountPrice) ?? "0")원"
        }
        else {
            arrowLabel.isHidden = true
            salePriceLabel.isHidden = true
        }
        
        if let urlStr = menu.imageURL, let url = URL(string: urlStr) {
            titleImageView.kf.setImage(with: url)
        }
    }
}
