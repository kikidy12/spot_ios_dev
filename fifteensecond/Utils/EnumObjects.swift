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
    case play = "Play"
    case beauty = "Beauty"
    
    static var allCase = [restaurant, tickets, play, beauty]
}

enum PayType: String {
    case card = "card"
    case phone = "phone"
}

enum CardInfoEnum: String {
    case wooriCard = "우리은행"
    case shinhanCard = "신한은행"
    case kakaoCard = "카카오뱅크"
    case nonghyeopCard = "농협"
    case ibkCard = "기업은행"
    case kbCard = "KB국민은행"
    case hanaCard = "하나은행(서울은행)"
    case anotherCard = "기타카드"
}


enum LinkType: String {
    case OUT = "OUT"
    case IN = "IN"
}


enum DateFormatterStyle: String {
    case dot = "."
    case hypoon = "-"
}
