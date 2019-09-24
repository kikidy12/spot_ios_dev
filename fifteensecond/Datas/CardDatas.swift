//
//  CardDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 02/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class CardDatas: NSObject {
    
    var id: Int!
    var name: String!
    var cardNum: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["card_name"] as? String
        if let str = data["card_num"] as? String {
            cardNum = "******" + String(str.suffix(4))
        }
    }
}
