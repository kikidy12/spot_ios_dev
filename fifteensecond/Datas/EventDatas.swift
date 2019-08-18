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
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        priority = data["priority"] as? Int
        imgaeURL = data["img_url"] as? String
        linkURL = data["link_url"] as? String
    }
}
