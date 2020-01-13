//
//  BeautyDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 08/10/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation

class BeautyDatas: NSObject {
    var id: Int!
    var address: String!
    var distance: Int!
    var is24hour = false
    var location: CLLocationCoordinate2D!
    var name: String!
    var phoneNum: String!
    var linkUrl: String!
    var openTime: String!
    var comment: String!
    var promotionCount: Int!
    var discountRate: Int!
    
    var isOpend: Bool = false
    
    var category = CategoryDatas()
    
    var imageList = [ImageDatas]()
    
    var menuList = [BeautyMenuDatas]()
    
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
            
            if oStr == "00:00", cStr == "00:00" {
                openTime = "24시간"
                isOpend = true
            }
            else {
                openTime = "\(oStr) - \(cStr)"
                
                let oHour = Int(oStr.split(separator: ":").first!)!
                let cHour = Int(cStr.split(separator: ":").first!)!
                let currentHour = Calendar.current.component(.hour, from: Date())
                
                let oMin = Int(oStr.split(separator: ":").last!)!
                let cMin = Int(cStr.split(separator: ":").last!)!
                let currentMin = Calendar.current.component(.minute, from: Date())
                
                if oHour < currentHour, cHour > currentHour {
                    isOpend = true
                }
                else if oHour == currentHour, oMin < currentMin {
                    isOpend = true
                }
                else if cHour == currentHour, cMin > currentMin {
                    isOpend = true
                }
                else {
                    isOpend = false
                }
            }
        }
        
        if let array = data["beauty_menu"] as? NSArray {
            menuList = array.compactMap { BeautyMenuDatas($0 as! NSDictionary) }
        }
        
        if let array = data["beauty_cover_images"] as? NSArray {
            imageList = array.compactMap { ImageDatas($0 as! NSDictionary) }
        }
        
        if let category = data["beauty_category"] as? NSDictionary {
            self.category = CategoryDatas(category)
        }
        
        discountRate = data["discount_rate"] as? Int
        linkUrl = data["link_url"] as? String
        comment = data["comment"] as? String
        name = data["name"] as? String
        phoneNum = data["phone_num"] as? String
        promotionCount = data["promotion_count"] as? Int
    }
}

class BeautyMenuDatas: NSObject {
    var id: Int!
    var price: Int!
    var name: String!
    var isMain = false
    var imageURL: String!
    var discountRate: Int!
    var salePrice: Int!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        price = data["price"] as? Int
        name = data["name"] as? String
        isMain = data["is_main"] as? Bool ?? false
        discountRate = data["discount_rate"] as? Int
        salePrice = data["sale_price"] as? Int
        
        if let dict = data["beauty_menu_images"] as? NSDictionary {
            imageURL = dict["img_url"] as? String
        }
    }
}
