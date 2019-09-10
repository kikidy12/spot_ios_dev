//
//  SpotTicketUseInfoDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 09/09/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class SpotTicketUseInfoDatas: NSObject {
    var id: Int!
    var usedTime: Date!
    var price: Int!
    var spot: SpotDatas!
    var expireDate: Date!
    var createdAt: Date!
    var ticketKind: SpotTicketDatas!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        let dateFormatter = DateFormatter()
        id = data["id"] as? Int
        price = data["price"] as? Int
        
        if let dateStr = data["used_time"] as? String {
            usedTime = DateFormatter().stringToDate(dateStr)
        }
        
        if let spotDict = data["spot"] as? NSDictionary {
            self.spot = SpotDatas(spotDict)
        }
        
        if let ticketDict = data["spot_ticket_kind"] as? NSDictionary {
            self.ticketKind = SpotTicketDatas(ticketDict)
        }
        
        if let dateStr = data["expire_date"] as? String {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            expireDate = dateFormatter.date(from: dateStr)
        }
        
        if let dateStr = data["created_at"] as? String {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            createdAt = dateFormatter.date(from: dateStr)
        }
    }
}
