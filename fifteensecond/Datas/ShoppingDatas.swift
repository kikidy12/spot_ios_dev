//
//  ShoppingDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 17/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit
import CoreLocation

class ShoppingDatas: NSObject {
    var id: Int!
    var address: String!
    var distance: Int!
    var is24hour = false
    var location: CLLocationCoordinate2D!
    var name: String!
    var phoneNum: String!
    var comment: String!
    var openTime: String!
    var linkUrl: String!
    var promotionCount: Int!
    
    var category = CategoryDatas()
    
    var imageList = [ImageDatas]()
    
    var menuList = [ShoppingMenuDatas]()
    
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
        
        if let dict = data["shopping_sales"] as? NSDictionary {
            comment = dict["name"] as? String
        }
        
        if let oTime = data["open_time"] as? String, let cTime = data["close_time"] as? String {
            let oIndex = oTime.index(oTime.endIndex, offsetBy: -3)
            let cIndex = cTime.index(cTime.endIndex, offsetBy: -3)
            let oStr = oTime[..<oIndex]
            let cStr = cTime[..<cIndex]
            
            openTime = "\(oStr) - \(cStr)"
        }
        
        linkUrl = data["link_url"] as? String
        
        if let array = data["shopping_brands"] as? NSArray {
            menuList = array.compactMap { ShoppingMenuDatas($0 as! NSDictionary) }
        }
        
        if let array = data["shopping_cover_images"] as? NSArray {
            imageList = array.compactMap { ImageDatas($0 as! NSDictionary) }
        }
        
        if let category = data["category"] as? NSDictionary {
            self.category = CategoryDatas(category)
        }
        
        comment = data["comment"] as? String
        name = data["name"] as? String
        phoneNum = data["phone_num"] as? String
        promotionCount = data["promotion_count"] as? Int
    }
}


class ShoppingMenuDatas: NSObject {
    var id: Int!
    var price: Int!
    var name: String!
    var isHot = false
    var imageURL: String!
    var comment: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        price = data["price"] as? Int
        name = data["name"] as? String
        isHot = data["is_hot"] as? Bool ?? false
        comment = (data["shopping_brand_sales"] as! NSDictionary)["name"] as? String
        imageURL = data["logo_img_url"] as? String
    }
}
