//
//  NationCodeData.swift
//  fifteensecond
//
//  Created by 권성민 on 14/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class NationCodeData: NSObject {
    
    var id: Int!
    var name: String!
    var code: String!
    var imgUrl: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
        code = data["code"] as? String
        imgUrl = data["img_url"] as? String
    }
}
