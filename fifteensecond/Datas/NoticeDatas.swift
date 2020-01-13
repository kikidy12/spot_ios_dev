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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let dateStr = data["created_at"] as? String, let date = dateStr.split(separator: " ").first {
            let year = date.split(separator: "-")[0]
            let month = date.split(separator: "-")[1]
            let day = date.split(separator: "-")[2]
            var component = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            component.year = Int(year)
            component.month = Int(month)
            component.day = Int(day)
            createdAt = Calendar.current.date(from: component)
        }
        if let dateStr = data["updated_at"] as? String {
            print(dateStr)
            updatedAt = dateStr.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
            print(updatedAt)
        }
    }
}
