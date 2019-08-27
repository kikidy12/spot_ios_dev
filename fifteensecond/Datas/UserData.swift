//
//  UserData.swift
//  fifteensecond
//
//  Created by 권성민 on 01/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//

import UIKit

class UserData: NSObject {
    
    var id: Int!
    var name: String!
    var email: String!
    var nationalCode: String!
    var phoneNum: String!
    var provider: String!
    var uid: String!
    var isAttend = false
    
    override init() {
        
    }
    
    init(_ data: NSDictionary, isAttend: Bool = false) {
        id = data["id"] as? Int
        name = data["name"] as? String
        email = data["email"] as? String
        nationalCode = data["national_code"] as? String
        phoneNum = data["phone_num"] as? String
        provider = data["provider"] as? String
        uid = data["uid"] as? String
        self.isAttend = isAttend
    }
}
