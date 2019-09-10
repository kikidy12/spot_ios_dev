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
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    

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
        }
    }
    
    func drawHotelViews() {
        openTimeLabel.text = "In \(hotel.sleepInTime ?? "00:00")/ Out \(hotel.sleepOutTime ?? "00:00")"
        nameLabel.text = hotel.name
        distanceLabel.text = "\(hotel.distance ?? 0)m"
        categoryLabel.text = hotel.category.name
        setImageView(urlStr: hotel.imageList.first?.imageURL)
    }
    
    func drawTicketViews() {
        openTimeLabel.text = ticket.openTime
        nameLabel.text = ticket.name
        distanceLabel.text = "\(ticket.distance ?? 0)m"
        categoryLabel.text = ticket.category.name
        setImageView(urlStr: ticket.imageList.first?.imageURL)
//        commentLabel.text = ticket.comment
    }
    
    func drawRestaurantViews() {
        openTimeLabel.text = restaurant.openTime
        nameLabel.text = restaurant.name
        distanceLabel.text = "\(restaurant.distance ?? 0)m"
        categoryLabel.text = restaurant.category.name
        setImageView(urlStr: restaurant.imageList.first?.imageURL)
//        commentLabel.text = restaurant.comment
    }
    
    func drawShoppingViews() {
        openTimeLabel.text = shopping.openTime
        nameLabel.text = shopping.name
        distanceLabel.text = "\(shopping.distance ?? 0)m"
        categoryLabel.text = shopping.category.name
        setImageView(urlStr: shopping.imageList.first?.imageURL)
        commentLabel.text = shopping.comment
    }
    
    func setImageView(urlStr: String?) {
        if let urlStr = urlStr, let url = URL(string: urlStr) {
            titleImageView.kf.setImage(with: url)
        }
        else {
            titleImageView.image = UIImage()
        }
    }
}
