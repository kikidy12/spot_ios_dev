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
        if let dateStr = data["created_at"] as? String, let date = dateStr.split(separator: " ").first {
            let year = date.split(separator: "-")[0]
            let month = date.split(separator: "-")[1]
            let day = date.split(separator: "-")[2]
            var component = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            component.year = Int(year)
            component.month = Int(month)
            component.day = Int(day)
            createAt = Calendar.current.date(from: component)
        }
        if let dict = data["spot"] as? NSDictionary {
            spot = SpotDatas(dict)
        }
    }
}
