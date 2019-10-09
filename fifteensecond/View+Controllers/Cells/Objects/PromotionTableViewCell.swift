//
//  PromotionTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 08/10/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class PromotionTableViewCell: UITableViewCell {
    
    var promotion: PromotionDatas!
    var numberFormatter = NumberFormatter()
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var disCountPriceLabel: UILabel!
    @IBOutlet weak var discountRateLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var cancelLineView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ data: PromotionDatas) {
        promotion = data
        numberFormatter.numberStyle = .decimal
        
        if let menu = promotion.restaurant {
            drawRestaurant(menu)
        }
        
        if let menu = promotion.beauty {
            drawBeauty(menu)
        }
        
        if let menu = promotion.play {
            drawPlay(menu)
        }
        
    }
    
    func drawRestaurant(_ menu: RestaurantMenuDatas) {
        nameLabel.text = menu.name
        disCountPriceLabel.text = "\(numberFormatter.string(for: menu.price) ?? "0")원"
        priceLabel.text = "\(menu.price ?? 0)원"
        
        if let rate = menu.discountRate {
            cancelLineView.isHidden = false
            arrowLabel.isHidden = false
            var discountPrice = 0
            if let price = menu.price, price > 0 {
                discountPrice = price - Int(Double(price * rate) / 100)
            }
            discountRateLabel.text = "\(rate)%"
            disCountPriceLabel.text = "\(numberFormatter.string(for: discountPrice) ?? "0")원"
        }
        else {
            arrowLabel.isHidden = true
            disCountPriceLabel.isHidden = true
        }
        
        if let urlStr = menu.imageURL, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            menuImageView.kf.setImage(with: url)
        }
    }
    
    func drawPlay(_ menu: PlayMenuDatas) {
        nameLabel.text = menu.name
        disCountPriceLabel.text = "\(numberFormatter.string(for: menu.price) ?? "0")원"
        priceLabel.text = "\(menu.price ?? 0)원"
        
        if let rate = menu.discountRate {
            cancelLineView.isHidden = false
            arrowLabel.isHidden = false
            var discountPrice = 0
            if let price = menu.price, price > 0 {
                discountPrice = price - Int(Double(price * rate) / 100)
            }
            discountRateLabel.text = "\(rate)%"
            disCountPriceLabel.text = "\(numberFormatter.string(for: discountPrice) ?? "0")원"
        }
        else {
            arrowLabel.isHidden = true
            disCountPriceLabel.isHidden = true
        }
        
        if let urlStr = menu.imageURL, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            menuImageView.kf.setImage(with: url)
        }
    }
    
    func drawBeauty(_ menu: BeautyMenuDatas) {
        nameLabel.text = menu.name
        disCountPriceLabel.text = "\(numberFormatter.string(for: menu.price) ?? "0")원"
        priceLabel.text = "\(menu.price ?? 0)원"
        
        if let rate = menu.discountRate {
            cancelLineView.isHidden = false
            arrowLabel.isHidden = false
            var discountPrice = 0
            if let price = menu.price, price > 0 {
                discountPrice = price - Int(Double(price * rate) / 100)
            }
            discountRateLabel.text = "\(rate)%"
            disCountPriceLabel.text = "\(numberFormatter.string(for: discountPrice) ?? "0")원"
        }
        else {
            arrowLabel.isHidden = true
            disCountPriceLabel.isHidden = true
        }
        
        if let urlStr = menu.imageURL, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            menuImageView.kf.setImage(with: url)
        }
    }
}
