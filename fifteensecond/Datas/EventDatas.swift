//
//  EventDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 17/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class EventDatas: NSObject {
    var id: Int!
    var imgaeURL: String!
    var linkURL: String!
    var priority: Int!
    
    var inType: AlienceTitles!
    var inTypeId: Int!
    
    var linkType: LinkType = .OUT
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        priority = data["priority"] as? Int
        imgaeURL = data["img_url"] as? String
        
        if let str = data["type"] as? String {
            linkType = LinkType(rawValue: str) ?? .OUT
        }
        linkURL = data["link_url"] as? String
        if let str = data["in_type"] as? String {
            inType = AlienceTitles(rawValue: str)
            
        }
        inTypeId = data["in_type_id"] as? Int
    }
}
