//
//  AlienceTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import Kingfisher

class AlienceTableViewCell: UITableViewCell {
    
    var type: AlienceTitles!
    
    var hotel: HotelDatas!
    var restaurant: RestaurantDatas!
    var ticket: TicketDatas!
    var shopping: ShoppingDatas!
    var play: PlayDatas!
    var beauty: BeautyDatas!
    
    var isOpneStore:Bool = false {
        didSet {
            promotionStateView.subviews.forEach {
                if let view = $0 as? CustomView  {
                    view.backgroundColor = isOpneStore ? UIColor.green : UIColor.red
                }
                
                if let label = $0 as? UILabel  {
                    label.text = isOpneStore ? "이용가능" : "준비중"
                }
            }
            hideView.isHidden = isOpneStore
        }
    }
    
    
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var promotionStateView: UIView!
    @IBOutlet weak var hideView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(type: AlienceTitles, data: NSDictionary) {
        self.type = type
        
        switch type {
        case .restaurant:
            restaurant = RestaurantDatas(data)
            drawRestaurantViews()
            break
        case .shopping:
            shopping = ShoppingDatas(data)
            drawShoppingViews()
            break
        case .tickets:
            ticket = TicketDatas(data)
            drawTicketViews()
            break
        case .hotel:
            hotel = HotelDatas(data)
            drawHotelViews()
            break
        case .play:
            play = PlayDatas(data)
            drawPlayViews()
            break
        case .beauty:
            beauty = BeautyDatas(data)
            drawBeautyViews()
            break
        }
    }
    
    func setDistanceDisplay(_ distance: Int) {
        
        if distance >= 1000 {
            let distance = Double(distance)/100
            distanceLabel.text = "\(distance.rounded()/10)km"
        }
        else {
            distanceLabel.text = "\(distance)m"
        }
    }
    
    func drawHotelViews() {
        openTimeLabel.text = "In \(hotel.sleepInTime ?? "00:00")/ Out \(hotel.sleepOutTime ?? "00:00")"
        nameLabel.text = hotel.name
        setDistanceDisplay(hotel.distance ?? 0)
        categoryLabel.text = hotel.category.name
        setImageView(urlStr: hotel.imageList.first?.imageURL)
        discountLabel.superview?.isHidden = false
    }
    
    func drawTicketViews() {
        openTimeLabel.text = ticket.openTime
        nameLabel.text = ticket.name
        setDistanceDisplay(ticket.distance ?? 0)
        categoryLabel.text = ticket.category.name
        setImageView(urlStr: ticket.imageList.first?.imageURL)
        commentLabel.text = ticket.comment ?? "없음"
        discountLabel.superview?.isHidden = true
    }
    
    func drawRestaurantViews() {
        openTimeLabel.text = restaurant.openTime
        nameLabel.text = restaurant.name
        setDistanceDisplay(restaurant.distance ?? 0)
        categoryLabel.text = restaurant.category.name
        setImageView(urlStr: restaurant.imageList.first?.imageURL)
        commentLabel.text = restaurant.comment ?? "없음"
        discountLabel.text = "~\(restaurant.discountRate ?? 0)%"
        discountLabel.superview?.isHidden = false
        
//        isOpneStore = (restaurant.promotionCount > 0 || restaurant.isOpend)
    }
    
    func drawBeautyViews() {
        openTimeLabel.text = beauty.openTime
        nameLabel.text = beauty.name
        setDistanceDisplay(beauty.distance ?? 0)
        categoryLabel.text = beauty.category.name
        setImageView(urlStr: beauty.imageList.first?.imageURL)
        commentLabel.text = beauty.comment ?? "없음"
        discountLabel.text = "~\(beauty.discountRate ?? 0)%"
        discountLabel.superview?.isHidden = false
        
//        isOpneStore = (beauty.promotionCount > 0 || beauty.isOpend)
    }
    
    func drawPlayViews() {
        openTimeLabel.text = play.openTime
        nameLabel.text = play.name
        setDistanceDisplay(play.distance ?? 0)
        categoryLabel.text = play.category.name
        setImageView(urlStr: play.imageList.first?.imageURL)
        commentLabel.text = play.comment ?? "없음"
        discountLabel.text = "~\(play.discountRate ?? 0)%"
        discountLabel.superview?.isHidden = false
        
//        isOpneStore = (play.promotionCount > 0 || play.isOpend)
    }
    
    
    func drawShoppingViews() {
        openTimeLabel.text = shopping.openTime
        nameLabel.text = shopping.name
        setDistanceDisplay(shopping.distance ?? 0)
        categoryLabel.text = shopping.category.name
        setImageView(urlStr: shopping.imageList.first?.imageURL)
        commentLabel.text = shopping.comment
        discountLabel.superview?.isHidden = false
    }
    
    func setImageView(urlStr: String?) {
        if let str = urlStr {
            titleImageView.kf.setImage(with: URL(string: str), placeholder: UIImage(named: "placeholderImage"))
        }
    }
}
