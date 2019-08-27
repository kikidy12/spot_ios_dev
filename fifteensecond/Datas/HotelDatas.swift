//
//  HotelDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 17/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation

class HotelDatas: NSObject {
    var id: Int!
    var address: String!
    var distance: Double!
    var is24hour = false
    var location: CLLocationCoordinate2D!
    var name: String!
    var phoneNum: String!
    
    
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        address = data["address"] as? String
        distance = data["distance"] as? Double
        is24hour = data["is_24hour"] as? Bool ?? false
        
        
        if let lat = data["latitude"] as? Double, let lng = data["longitude"] as? Double {
            location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        
        name = data["name"] as? String
        phoneNum = data["phone_num"] as? String
    }
}

class HotelMenuDatas: NSObject {
    
}
