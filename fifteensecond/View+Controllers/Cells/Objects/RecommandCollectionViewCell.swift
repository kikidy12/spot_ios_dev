//
//  RecommandCollectionViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class RecommandCollectionViewCell: UICollectionViewCell {
    
    var type: AlienceTitles!
    
    var hotel: HotelDatas!
    var restaurant: RestaurantDatas!
    var ticket: TicketDatas!
    var shopping: ShoppingDatas!
    var play: PlayDatas!
    var beauty: BeautyDatas!
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        case .beauty:
            beauty = BeautyDatas(data)
            drawBeautyViews()
        }
    }
    
    func drawHotelViews() {
        openTimeLabel.text = "In \(hotel.sleepInTime ?? "00:00")/ Out \(hotel.sleepOutTime ?? "00:00")"
        nameLabel.text = hotel.name
        setDistanceDisplay(hotel.distance ?? 0)
        setImageView(urlStr: hotel.imageList.first?.imageURL)
        commentLabel.text = hotel.comment ?? "없음"
    }
    
    func drawTicketViews() {
        openTimeLabel.text = ticket.openTime
        nameLabel.text = ticket.name
        setDistanceDisplay(ticket.distance ?? 0)
        setImageView(urlStr: ticket.imageList.first?.imageURL)
        commentLabel.text = ticket.comment ?? "없음"
    }
    
    func drawRestaurantViews() {
        openTimeLabel.text = restaurant.openTime
        nameLabel.text = restaurant.name
        setDistanceDisplay(restaurant.distance ?? 0)
        setImageView(urlStr: restaurant.imageList.first?.imageURL)
        commentLabel.text = restaurant.comment ?? "없음"
    }
    
    func drawShoppingViews() {
        openTimeLabel.text = shopping.openTime
        nameLabel.text = shopping.name
        setDistanceDisplay(shopping.distance ?? 0)
        setImageView(urlStr: shopping.imageList.first?.imageURL)
        commentLabel.text = shopping.comment ?? "없음"
    }
    
    func drawPlayViews() {
        openTimeLabel.text = play.openTime
        nameLabel.text = play.name
        setDistanceDisplay(play.distance ?? 0)
        setImageView(urlStr: play.imageList.first?.imageURL)
        commentLabel.text = play.comment ?? "없음"
    }
    
    func drawBeautyViews() {
        openTimeLabel.text = beauty.openTime
        nameLabel.text = beauty.name
        setDistanceDisplay(beauty.distance ?? 0)
        setImageView(urlStr: beauty.imageList.first?.imageURL)
        commentLabel.text = beauty.comment ?? "없음"
    }
    
    func setImageView(urlStr: String?) {
        if let urlStr = urlStr, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            titleImageView.kf.setImage(with: url)
        }
    }
}
