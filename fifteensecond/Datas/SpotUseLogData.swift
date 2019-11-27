//
//  SpotUseLogData.swift
//  fifteensecond
//
//  Created by 권성민 on 2019/11/19.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SpotUseLogData: NSObject {
    var id: Int!
    var createAt: Date!
    var spot: SpotDatas!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        if let dateStr = data["created_at"] as? String {
            createAt = dateStr.stringToDate()
        }
        if let dict = data["spot"] as? NSDictionary {
            spot = SpotDatas(dict)
        }
    }
}
