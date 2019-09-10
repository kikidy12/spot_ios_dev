//
//  SpotTicketDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SpotTicketDatas: NSObject {
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
