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
    
    var category = CategoryDatas()
    
    var imageList = [TicketImageDatas]()
    
    var facilityList = [FacilityDatas]()
    
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
            
            openTime = "\(oStr) - \(cStr)"
        }
        
        if let array = data["ticket_facilities"] as? NSArray {
            facilityList = array.compactMap { FacilityDatas($0 as! NSDictionary) }
        }
        
        if let array = data["ticket_cover_images"] as? NSArray {
            imageList = array.compactMap { TicketImageDatas($0 as! NSDictionary) }
        }
        
        if let category = data["ticket_category"] as? NSDictionary {
            self.category = CategoryDatas(category)
        }
        
        linkUrl = data["link_url"] as? String
        
        name = data["name"] as? String
        phoneNum = data["phone_num"] as? String
    }
}

class TicketImageDatas: NSObject {
    var id: Int!
    var imageURL: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
    }
}

class FacilityDatas: NSObject {
    var id: Int!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
    }
}
