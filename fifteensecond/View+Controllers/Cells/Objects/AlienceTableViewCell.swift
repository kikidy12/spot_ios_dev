//
//  AlienceTableViewCell.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

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
            drawShoppingViews()
            break
        case .tickets:
            drawTicketViews()
            break
        case .hotel:
            drawHotelViews()
            break
        }
    }
    
    func drawHotelViews() {
        nameLabel.text = hotel.name
    }
    
    func drawTicketViews() {
        
    }
    
    func drawRestaurantViews() {
        openTimeLabel.text = restaurant.openTime
        nameLabel.text = restaurant.name
        distanceLabel.text = "\(restaurant.distance ?? 0)m"
    }
    
    func drawShoppingViews() {
        
    }
}
