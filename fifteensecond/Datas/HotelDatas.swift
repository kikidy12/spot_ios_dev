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
    var distance: Int!
    var location: CLLocationCoordinate2D!
    var name: String!
    var phoneNum: String!
    var comment: String!
    var linkURL: String!
    
    var rentInTime: String!
    var rentOutTime: String!
    var sleepInTime: String!
    var sleepOutTime: String!
    
    var category = CategoryDatas()
    
    var imageList = [ImageDatas]()
    
    var facilityList = [FacilityDatas]()
    
    var roomList = [HotelRoomDatas]()
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        id = data["id"] as? Int
        address = data["address"] as? String
        
        linkURL = data["link_url"] as? String
        if let dist = data["distance"] as? Double {
            distance = Int((dist * 1000))
        }
        
        
        if let lat = data["latitude"] as? Double, let lng = data["longitude"] as? Double {
            location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        
        if let array = data["hotel_cover_images"] as? NSArray {
            imageList = array.compactMap { ImageDatas($0 as! NSDictionary) }
        }
        
        if let category = data["hotel_category"] as? NSDictionary {
            self.category = CategoryDatas(category)
        }
        
        name = data["name"] as? String
        phoneNum = data["phone_num"] as? String
        comment = data["comment"] as? String
        
        if let array = data["hotel_facilities"] as? NSArray {
            facilityList = array.compactMap { FacilityDatas($0 as! NSDictionary) }
        }
        
        if let array = data["hotel_room"] as? NSArray {
            roomList = array.compactMap { HotelRoomDatas($0 as! NSDictionary) }
        }
        
        if let str = data["rent_check_in_time"] as? String {
            rentInTime = str.split(separator: ":").dropLast().joined(separator: ":")
        }
        
        if let str = data["rent_check_out_time"] as? String {
            rentOutTime = str.split(separator: ":").dropLast().joined(separator: ":")
        }
        
        if let str = data["sleep_check_in_time"] as? String {
            sleepInTime = str.split(separator: ":").dropLast().joined(separator: ":")
        }
        
        if let str = data["sleep_check_out_time"] as? String {
            sleepOutTime = str.split(separator: ":").dropLast().joined(separator: ":")
        }
        
    }
}

class HotelRoomDatas: NSObject {
    var id: Int!
    var name: String!
    
    var maxRentTime: Int!
    var checkInTime: String!
    
    var imageList = [ImageDatas]()
    
    var sleepRoomInfo: HotelRoomPriceDatas?
    var rentRoomInfo: HotelRoomPriceDatas?
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        id = data["id"] as? Int
        name = data["name"] as? String
        
        if let array = data["hotel_room_images"] as? NSArray {
            imageList = array.compactMap { ImageDatas($0 as! NSDictionary) }
        }
        
        if let str = data["sleep_check_in_time"] as? String {
            checkInTime = str.split(separator: ":").dropLast().joined(separator: ":")
        }
        
        maxRentTime = data["max_rent_time"] as? Int
        
        if let array = data["hotel_room_prices"] as? NSArray {
            if let sleepInfo = array.first(where: {
                if (($0 as! NSDictionary)["day_type"] as! String) == "WEEKDAY", (($0 as! NSDictionary)["type"] as! String) == "SLEEP" {
                    return true
                }
                else {
                    return false
                }
            }) {
                self.sleepRoomInfo = HotelRoomPriceDatas(sleepInfo as! NSDictionary, maxTime: nil, inTime: nil)
            }
            
            
            if let rentInfo = array.first(where: {
                if (($0 as! NSDictionary)["day_type"] as! String) == "WEEKDAY", (($0 as! NSDictionary)["type"] as! String) == "RENT" {
                    return true
                }
                else {
                    return false
                }
            }) {
                self.rentRoomInfo = HotelRoomPriceDatas(rentInfo as! NSDictionary, maxTime: nil, inTime: nil)
            }
            
            
        }
    }
}

class HotelRoomPriceDatas: NSObject {
    var id: Int!
    var discountRate: Int!
    var price: Int!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary, maxTime: Int?, inTime: String?) {
        id = data["id"] as? Int
        discountRate = data["discount_rate"] as? Int
        price = data["price"] as? Int
    }
}

