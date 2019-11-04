//
//  RouletteDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/11/04.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class RouletteDatas: NSObject {
    
    var id: Int!
    var name: String!
    var goodsNo: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
        goodsNo = data["ggods_no"] as? String
    }
}
