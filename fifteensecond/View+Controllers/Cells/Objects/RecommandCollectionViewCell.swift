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
        distanceLabel.text = "\(hotel.distance ?? 0)m"
        setImageView(urlStr: hotel.imageList.first?.imageURL)
        commentLabel.text = hotel.comment ?? ""
    }
    
    func drawTicketViews() {
        openTimeLabel.text = ticket.openTime
        nameLabel.text = ticket.name
        distanceLabel.text = "\(ticket.distance ?? 0)m"
        setImageView(urlStr: ticket.imageList.first?.imageURL)
        commentLabel.text = ticket.comment
    }
    
    func drawRestaurantViews() {
        openTimeLabel.text = restaurant.openTime
        nameLabel.text = restaurant.name
        distanceLabel.text = "\(restaurant.distance ?? 0)m"
        setImageView(urlStr: restaurant.imageList.first?.imageURL)
        commentLabel.text = restaurant.comment
    }
    
    func drawShoppingViews() {
        openTimeLabel.text = shopping.openTime
        nameLabel.text = shopping.name
        distanceLabel.text = "\(shopping.distance ?? 0)m"
        setImageView(urlStr: shopping.imageList.first?.imageURL)
        commentLabel.text = shopping.comment
    }
    
    func drawPlayViews() {
        openTimeLabel.text = play.openTime
        nameLabel.text = play.name
        distanceLabel.text = "\(play.distance ?? 0)m"
        setImageView(urlStr: play.imageList.first?.imageURL)
        commentLabel.text = play.comment
    }
    
    func drawBeautyViews() {
        openTimeLabel.text = beauty.openTime
        nameLabel.text = beauty.name
        distanceLabel.text = "\(beauty.distance ?? 0)m"
        setImageView(urlStr: beauty.imageList.first?.imageURL)
        commentLabel.text = beauty.comment
    }
    
    func setImageView(urlStr: String?) {
        if let urlStr = urlStr, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            titleImageView.kf.setImage(with: url)
        }
    }
}
