//
//  ProviderDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 26/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class ProviderDatas: NSObject {
    var id: Int!
    var provider: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        provider = data["provider"] as? String
    }
}
