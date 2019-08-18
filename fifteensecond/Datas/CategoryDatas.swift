//
//  CategoryDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 17/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class CategoryDatas: NSObject {

    var id: Int!
    var name: String!
    var isSelect = false
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
    }
    
    init(name: String) {
        self.name = name
        id = 0
        isSelect = false
    }
}
