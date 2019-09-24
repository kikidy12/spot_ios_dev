//
//  CustomMarkerInfoWindowView.swift
//  fifteensecond
//
//  Created by 권성민 on 20/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class CustomMarkerInfoWindowView: UIView {
    
    
    var selectClouser: ((Any?)->())!
    private let xibName = "CustomMarkerInfoWindowView"
    
    var alienceData: Any!

    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alienceImageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    @IBAction func showDetailEvent(_ sender: Any) {
        selectClouser(alienceData)
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func initView(data: Any) {
        alienceData = data
        
        if let restaurant = alienceData as? RestaurantDatas {
            nameLabel.text = restaurant.name
            distanceLabel.text = "\(restaurant.distance ?? 0)m"
            categoryLabel.text = restaurant.category.name
            openTimeLabel.text = restaurant.openTime
            setImageView(urlStr: restaurant.imageList.first?.imageURL)
        }
        else if let ticket = alienceData as? TicketDatas {
            nameLabel.text = ticket.name
            distanceLabel.text = "\(ticket.distance ?? 0)m"
            categoryLabel.text = ticket.category.name
            openTimeLabel.text = ticket.openTime
            setImageView(urlStr: ticket.imageList.first?.imageURL)
        }
        else if let shopping = alienceData as? ShoppingDatas {
            nameLabel.text = shopping.name
            distanceLabel.text = "\(shopping.distance ?? 0)m"
            categoryLabel.text = shopping.category.name
            openTimeLabel.text = shopping.openTime
            setImageView(urlStr: shopping.imageList.first?.imageURL)
        }
        else if let hotel = alienceData as? HotelDatas {
            nameLabel.text = hotel.name
            distanceLabel.text = "\(hotel.distance ?? 0)m"
            categoryLabel.text = hotel.category.name
            openTimeLabel.text = "Check In \(hotel.sleepInTime!)/ Out \(hotel.sleepOutTime!)"
            setImageView(urlStr: hotel.imageList.first?.imageURL)
        }
    }
    
    func setImageView(urlStr: String?) {
        if let urlStr = urlStr, let url = URL(string: urlStr) {
            alienceImageView.kf.setImage(with: url)
        }
        else {
            alienceImageView.image = UIImage()
        }
    }
    

}
