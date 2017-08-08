//
//  AccountR.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-24.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import Foundation
import RealmSwift

class AccountR : Object {
    
    dynamic var id = NSUUID().uuidString
    dynamic var accountName : String = ""
    dynamic var accountNumber = ""
    dynamic var bankName = ""
    dynamic var balance : Double =  0.0
  
    override static func primaryKey() -> String? {
        return "id"
    }
}
