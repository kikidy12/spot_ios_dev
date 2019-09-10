//
//  HotelRoomInfoTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 10/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class HotelRoomInfoTableViewCell: UITableViewCell {
    
    var room: HotelRoomDatas!
    
    let numberFormatter = NumberFormatter()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    
    
    //fulltime
    @IBOutlet weak var fullHeaderLabel: UILabel!
    @IBOutlet weak var fullTimeLabel: UILabel!
    @IBOutlet weak var fullPriceLabel: UILabel!
    @IBOutlet weak var fullDisPriceLabel: UILabel!
    @IBOutlet weak var fullDisRateLabel: UILabel!
    @IBOutlet weak var fullCancelLineView: UIView!
    
    
    //parttime
    @IBOutlet weak var partHeaderLabel: UILabel!
    @IBOutlet weak var partTimeLabel: UILabel!
    @IBOutlet weak var partPriceLabel: UILabel!
    @IBOutlet weak var partDisPriceLabel: UILabel!
    @IBOutlet weak var partDisRateLabel: UILabel!
    @IBOutlet weak var partCancelLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberFormatter.numberStyle = .decimal
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func initView(_ data: HotelRoomDatas) {
        room = data
        
        nameLabel.text = room.name
        
        if let urlStr = room.imageList.first?.imageURL {
            let url = URL(string: urlStr)
            
            titleImageView.kf.setImage(with: url)
        }
        else {
            titleImageView.image = UIImage()
        }
        
        if let sleep = room.sleepRoomInfo {
            fullTimeLabel.text = "\(room.checkInTime ?? "00:00") 부터"
            if sleep.discountRate == 0 {
                fullDisPriceLabel.text = "\(numberFormatter.string(for: sleep.price) ?? "0")원"
                fullPriceLabel.isHidden = true
                fullDisRateLabel.isHidden = true
                fullCancelLineView.isHidden = true
            }
            else {
                fullDisPriceLabel.text = "\(numberFormatter.string(for: sleep.price * (100 - sleep.discountRate) / 100) ?? "0")원"
                fullPriceLabel.text = "\(numberFormatter.string(for: sleep.price) ?? "0")원"
                fullPriceLabel.isHidden = false
                fullDisRateLabel.isHidden = false
                fullCancelLineView.isHidden = false
                fullDisRateLabel.text = "\(sleep.discountRate ?? 0)%"
            }
        }
        
        if let rent = room.rentRoomInfo {
            partTimeLabel.text = "최대 \(room.maxRentTime ?? 0)시간"
            partShow(isShow: false)
            if rent.discountRate == 0 {
                partDisPriceLabel.text = "\(numberFormatter.string(for: rent.price) ?? "0")원"
                partPriceLabel.isHidden = true
                partDisRateLabel.isHidden = true
                partCancelLineView.isHidden = true
            }
            else {
                partDisPriceLabel.text = "\(numberFormatter.string(for: rent.price * (100 - rent.discountRate) / 100) ?? "0")원"
                partPriceLabel.text = "\(numberFormatter.string(for: rent.price) ?? "0")원"
                partPriceLabel.isHidden = false
                partDisRateLabel.isHidden = false
                partCancelLineView.isHidden = false
                partDisRateLabel.text = "\(rent.discountRate ?? 0)%"
            }
        }
        else {
            partShow(isShow: true)
        }
    }
    
    func partShow(isShow: Bool = false) {
        if isShow {
            partHeaderLabel.textColor = .veryLightPinkTwo
            partTimeLabel.textColor = .veryLightPinkTwo
            partDisPriceLabel.textColor = .veryLightPinkTwo
            partTimeLabel.text = "최대 0시간"
            partPriceLabel.isHidden = true
            partDisRateLabel.isHidden = true
            partCancelLineView.isHidden = true
        }
        else {
            partHeaderLabel.textColor = .darkText
            partTimeLabel.textColor = .brownGrey
            partDisPriceLabel.textColor = .darkText
        }
    }
    
}
