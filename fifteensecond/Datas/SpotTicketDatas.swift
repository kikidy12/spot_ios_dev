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
    var usedTime: Date!
    var price: Int!
    
    var spot: SpotDatas!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        price = data["price"] as? Int
        
        if let dateStr = data["used_time"] as? String {
            usedTime = DateFormatter().stringToDate(dateStr)
        }
        
        if let spotDict = data["spot"] as? NSDictionary {
            self.spot = SpotDatas(spotDict)
        }
    }
}
