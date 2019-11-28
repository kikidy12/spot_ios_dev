//
//  File.swift
//  fifteensecond
//
//  Created by 권성민 on 14/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import Foundation

class GlobalDatas: NSObject {
    static var nationCodeList = [NationCodeData]()
    static var currentUser: UserData!
    
    static var deviceToken = ""
    static var isPush = false
    static var spotTicketBuyDict = [
        "count": 0,
        "type": PayType.card
    ] as [String:Any]
}


class ImageDatas: NSObject {
    var id: Int!
    var imageURL: String!
    var displayOrder: Int!
    var isRepresent: Bool!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        imageURL = data["img_url"] as? String
        displayOrder = data["display_order"] as? Int
        isRepresent = data["is_represent"] as? Bool
    }
}

