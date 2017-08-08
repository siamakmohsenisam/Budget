//
//  BudgetR.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-24.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import Foundation
import RealmSwift

class BudgetR : Object{
    
    dynamic var id = NSUUID().uuidString
    
    dynamic var account : AccountR?
    dynamic var category : CategoryR?
    dynamic var date = Date()
    dynamic var amount : Double = 0.0
    
    override static func indexedProperties() -> [String]{
        return ["date"]
    }
    override static func primaryKey() -> String?{
        return "id"
    }
}



