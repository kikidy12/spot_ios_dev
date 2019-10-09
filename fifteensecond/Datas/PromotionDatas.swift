//
//  PromotionDatas.swift
//  fifteensecond
//
//  Created by 권성민 on 08/10/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class PromotionDatas: NSObject {
    var id: Int!
    var type: String = "restaurant"
    var title: String!
    
    var play: PlayMenuDatas!
    var restaurant: RestaurantMenuDatas!
    var beauty: BeautyMenuDatas!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        type = data["type"] as? String ?? "restaurant"
        title = data["title"] as? String
        
        if let menu = data["menu"] as? NSDictionary {
            restaurant = nil
            beauty = nil
            play = nil
            if type == "restaurant" {
                restaurant = RestaurantMenuDatas(menu)
            }
            else if type == "beauty" {
                beauty = BeautyMenuDatas(menu)
            }
            else if type == "play" {
                play = PlayMenuDatas(menu)
            }
        }
        
    }
}
