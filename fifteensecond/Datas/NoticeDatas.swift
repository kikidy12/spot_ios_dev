//
//  NoticeDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 27/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class NoticeDatas: NSObject {
    var id: Int!
    var title: String!
    var content: String!
    var createdAt: Date!
    var updatedAt: Date!
    
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        title = data["title"] as? String
        content = data["content"] as? String
        
        if let dateStr = data["created_at"] as? String {
            createdAt = DateFormatter().stringToDate(dateStr)
        }
        if let dateStr = data["updated_at"] as? String {
            updatedAt = DateFormatter().stringToDate(dateStr)
        }
    }
}
