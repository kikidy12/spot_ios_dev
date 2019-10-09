//
//  AlienceDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 17/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class AlienceDatas: NSObject {
    
    var type: AlienceTitles!
    var array: NSArray!
    
    override init() {
        
    }
    
    init(type: AlienceTitles, _ data: NSDictionary) {
        self.type = type
        switch type {
        case .restaurant:
            array = data["restaurant"] as? NSArray
            break
        case .shopping:
            array = data["shopping_mall"] as? NSArray
            break
        case .tickets:
            array = data["ticket"] as? NSArray
            break
        case .hotel:
            array = data["hotel"] as? NSArray
            break
        case .play:
            array = data["play"] as? NSArray
        case .beauty:
            array = data["beauty"] as? NSArray
        }
    }
}
