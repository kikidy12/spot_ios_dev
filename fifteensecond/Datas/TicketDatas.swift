//
//  TicketDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 17/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation

class TicketDatas: NSObject {
    var id: Int!
    var address: String!
    var distance: Int!
    var location: CLLocationCoordinate2D!
    var name: String!
    var phoneNum: String!
    var linkUrl: String!
    var openTime: String!
    var comment: String!
    var promotionCount: Int!
    
    var discountRate: Int!
    
    var category = CategoryDatas()
    
    var imageList = [ImageDatas]()
    
    var facilityList = [FacilityDatas]()
    
    var kindList = [TicketKindDatas]()
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        address = data["address"] as? String
        
        if let dist = data["distance"] as? Double {
            distance = Int((dist * 1000))
        }
        
        if let lat = data["latitude"] as? Double, let lng = data["longitude"] as? Double {
            location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        
        if let oTime = data["open_time"] as? String, let cTime = data["close_time"] as? String {
            let oIndex = oTime.index(oTime.endIndex, offsetBy: -3)
            let cIndex = cTime.index(cTime.endIndex, offsetBy: -3)
            let oStr = oTime[..<oIndex]
            let cStr = cTime[..<cIndex]
            
            if oStr == "00:00", cStr == "00:00" {
                openTime = "24시간"
            }
            else {
                openTime = "\(oStr) - \(cStr)"
            }
        }
        
        if let array = data["ticket_facilities"] as? NSArray {
            facilityList = array.compactMap { FacilityDatas($0 as! NSDictionary) }
        }
        
        if let array = data["ticket_cover_images"] as? NSArray {
            imageList = array.compactMap { ImageDatas($0 as! NSDictionary) }
        }
        
        if let category = data["ticket_category"] as? NSDictionary {
            self.category = CategoryDatas(category)
        }
        
        if let array = data["ticket_kinds"] as? NSArray {
            self.kindList = array.compactMap { TicketKindDatas($0 as! NSDictionary) }
        }
        
        discountRate = data["discount_rate"] as? Int
        linkUrl = data["link_url"] as? String
        comment = data["comment"] as? String
        name = data["name"] as? String
        phoneNum = data["phone_num"] as? String
        promotionCount = data["promotion_count"] as? Int
    }
}

class TicketKindDatas: NSObject {
    var id: Int!
    var name: String!
    var price: Int!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
        price = data["price"] as? Int
    }
}


class FacilityDatas: NSObject {
    var id: Int!
    var name: String!
    var imgUrl: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = (data["facilities"] as! NSDictionary)["id"] as? Int
        name = (data["facilities"] as! NSDictionary)["name"] as? String
        imgUrl = (data["facilities"] as! NSDictionary)["img_url"] as? String
    }
}
