//
//  CategoryR.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-24.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryR: Object {

    dynamic var id = NSUUID().uuidString
    dynamic var categoryName : String = ""

    override static func primaryKey() -> String?{
        return "id"
    }
    
}
