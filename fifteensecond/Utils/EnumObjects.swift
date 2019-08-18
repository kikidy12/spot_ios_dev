//
//  EnumObjects.swift
//  fifteensecond
//
//  Created by 권성민 on 01/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import Foundation


enum AlienceTitles: String {
    case restaurant = "Restaurant"
    case shopping = "Shopping"
    case tickets = "Tickets"
    case hotel = "Hotel"
    
    static var allCase = [restaurant, shopping, tickets, hotel]
}


enum TestEnum: CaseIterable {
    case test1, test2, test3
}
