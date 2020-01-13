//
//  CouponDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/11/04.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class CouponDatas: NSObject {
    
    var id: Int!
    var barcodeUrl: String!
    var brandName: String!
    var brandImgUrl: String!
    var goodsName: String!
    var goodsImgUrl: String!
    var limitDay: Date!
    var reciveDate: Date!
    var content: String!
    var status: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        barcodeUrl = data["barcode_url"] as? String
        brandName = data["brand_name"] as? String
        brandImgUrl = data["brand_img_url"] as? String
        goodsName = data["goods_name"] as? String
        goodsImgUrl = data["goods_img_url"] as? String
        content = data["content"] as? String
        status = data["status"] as? String
        
        if let str = data["limit_day"] as? String {
            limitDay = str.stringToDate(formatter: "yyyy-MM-dd")
        }
        
        if let str = data["recive_date"] as? String {
            reciveDate = str.stringToDate(formatter: "yyyy-MM-dd")
        }
        
        print(limitDay)
        print(reciveDate)
    }
}
