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
    
    
    func initView(restaurant: RestaurantMenuDatas? = nil, play: PlayMenuDatas? = nil, beauty: BeautyMenuDatas? = nil) {
        numberFormatter.numberStyle = .decimal
        
        if let menu = restaurant {
            drawRestaurant(menu)
        }
        else if let menu = play {
            drawPlay(menu)
        }
        else if let menu = beauty {
            drawBeauty(menu)
        }
    }
    
    func drawRestaurant(_ menu: RestaurantMenuDatas) {
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
        
        if let urlStr = menu.imageURL, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            titleImageView.kf.setImage(with: url)
        }
    }
    
    func drawBeauty(_ menu: BeautyMenuDatas) {
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
        
        if let urlStr = menu.imageURL, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            titleImageView.kf.setImage(with: url)
        }
    }
    
    func drawPlay(_ menu: PlayMenuDatas) {
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
        
        if let urlStr = menu.imageURL, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            titleImageView.kf.setImage(with: url)
        }
    }
}
