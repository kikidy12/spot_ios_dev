//
//  RestaurantDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 17/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation

class RestaurantDatas: NSObject {
    var id: Int!
    var address: String!
    var distance: Int!
    var is24hour = false
    var location: CLLocationCoordinate2D!
    var name: String!
    var phoneNum: String!
    
    var openTime: String!
    
    var imageList = [String]()
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        address = data["address"] as? String
        
        if let dist = data["distance"] as? Double {
            distance = Int((dist * 1000))
        }
        is24hour = data["is_24hour"] as? Bool ?? false
        
        if let lat = data["latitude"] as? Double, let lng = data["longitude"] as? Double {
            location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        
        if let oTime = data["open_time"] as? String, let cTime = data["close_time"] as? String {
            let oIndex = oTime.index(oTime.endIndex, offsetBy: -3)
            let cIndex = cTime.index(cTime.endIndex, offsetBy: -3)
            let oStr = oTime[..<oIndex]
            let cStr = cTime[..<cIndex]
            
            openTime = "\(oStr) - \(cStr)"
        }
        
        name = data["name"] as? String
        phoneNum = data["phone_num"] as? String
    }
}
