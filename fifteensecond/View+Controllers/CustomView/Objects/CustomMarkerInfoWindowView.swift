//
//  CustomMarkerInfoWindowView.swift
//  fifteensecond
//
//  Created by 권성민 on 20/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation


class CustomMarkerInfoWindowView: UIView {
    
    var selectClouser: ((Any?)->())!
    private let xibName = "CustomMarkerInfoWindowView"
    
    var locationManager = CLLocationManager()
    
    var alienceData: Any!
    
    var location: CLLocation!

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
    
    func setDistanceDisplay(_ distance: Int) {
        if distance >= 1000 {
            let distance = Double(distance)/100
            distanceLabel.text = "\(distance.rounded()/10)km"
        }
        else {
            distanceLabel.text = "\(distance)m"
        }
    }
    
    func setDistanceDisplay(_ distance: Double) {
        if distance >= 1000 {
            let distance = distance/100
            distanceLabel.text = "\(distance.rounded()/10)km"
        }
        else {
            distanceLabel.text = "\(Int(distance))m"
        }
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func initView(data: Any) {
        alienceData = data
        
        if let restaurant = alienceData as? RestaurantDatas {
            location = CLLocation(latitude: restaurant.location.latitude, longitude: restaurant.location.longitude)
            nameLabel.text = restaurant.name
            setDistanceDisplay(restaurant.distance ?? 0)
            categoryLabel.text = restaurant.category.name
            openTimeLabel.text = restaurant.openTime
            commentLabel.text = restaurant.comment ?? "없음"
            setImageView(urlStr: restaurant.imageList.first?.imageURL)
        }
        else if let ticket = alienceData as? TicketDatas {
            nameLabel.text = ticket.name
            setDistanceDisplay(ticket.distance ?? 0)
            categoryLabel.text = ticket.category.name
            openTimeLabel.text = ticket.openTime
            commentLabel.text = ticket.comment ?? "없음"
            setImageView(urlStr: ticket.imageList.first?.imageURL)
        }
        else if let shopping = alienceData as? ShoppingDatas {
            nameLabel.text = shopping.name
            setDistanceDisplay(shopping.distance ?? 0)
            categoryLabel.text = shopping.category.name
            openTimeLabel.text = shopping.openTime
            commentLabel.text = shopping.comment ?? "없음"
            setImageView(urlStr: shopping.imageList.first?.imageURL)
        }
        else if let hotel = alienceData as? HotelDatas {
            nameLabel.text = hotel.name
            setDistanceDisplay(hotel.distance ?? 0)
            categoryLabel.text = hotel.category.name
            commentLabel.text = hotel.comment ?? "없음"
            openTimeLabel.text = "Check In \(hotel.sleepInTime!)/ Out \(hotel.sleepOutTime!)"
            setImageView(urlStr: hotel.imageList.first?.imageURL)
        }
        
        else if let play = alienceData as? PlayDatas {
            location = CLLocation(latitude: play.location.latitude, longitude: play.location.longitude)
            nameLabel.text = play.name
            categoryLabel.text = play.category.name
            commentLabel.text = play.comment ?? "없음"
            openTimeLabel.text = play.openTime
            setImageView(urlStr: play.imageList.first?.imageURL)
        }
        
        else if let beauty = alienceData as? BeautyDatas {
            location = CLLocation(latitude: beauty.location.latitude, longitude: beauty.location.longitude)
            nameLabel.text = beauty.name
            categoryLabel.text = beauty.category.name
            commentLabel.text = beauty.comment ?? "없음"
            openTimeLabel.text = beauty.openTime
            setImageView(urlStr: beauty.imageList.first?.imageURL)
        }
        
//        locationManager.delegate = self
//        locationManager.activityType = .automotiveNavigation
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//
//        locationManager.distanceFilter = 10
//
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.startUpdatingLocation()
//        }
        
        if let loc = locationManager.location {
            setDistanceDisplay(loc.distance(from: location))
        }
    }
    
    func setImageView(urlStr: String?) {
        if let str = urlStr {
            alienceImageView.kf.setImage(with: URL(string: str), placeholder: UIImage(named: "placeholderImage"))
        }
//        if let urlStr = urlStr, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encoded) {
//            alienceImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"))
//        }
    }
    

}

//extension CustomMarkerInfoWindowView: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let loc = locationManager.location, let location = self.location {
//            setDistanceDisplay(loc.distance(from: location))
//        }
//    }
//}
