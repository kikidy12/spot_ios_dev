//
//  SpotDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation

class SpotDatas: NSObject {
    var id: Int!
    var name: String!
    var price: Int!
    var address: String!
    var openTime: String!
    var phoneNum: String!
    var location: CLLocationCoordinate2D!
    var distance: Int!
    var uniqueNumber: Int!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
        price = data["price"] as? Int
        address = data["address"] as? String
        phoneNum = data["phone_num"] as? String
        
        if let oTime = data["open_time"] as? String, let cTime = data["close_time"] as? String {
            let oIndex = oTime.index(oTime.endIndex, offsetBy: -3)
            let cIndex = cTime.index(cTime.endIndex, offsetBy: -3)
            let oStr = oTime[..<oIndex]
            let cStr = cTime[..<cIndex]
            
            openTime = "\(oStr) - \(cStr)"
        }
        
        
        if let lat = data["latitude"] as? Double, let lng = data["longitude"] as? Double {
            location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        
        if let dist = data["distance"] as? Double {
            distance = Int((dist * 1000))
        }
        
        uniqueNumber = data["unique_number"] as? Int
    }
}
