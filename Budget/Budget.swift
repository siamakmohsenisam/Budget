//
//  Budget.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-17.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import Foundation

class Budget {
    
    var account : Account
    var category : Category
    var date : Date
    var amount : Double
    
    convenience init() {
        self.init(account: Account() , category: Category() , date: Date() , amount: 0.0)
    }
    
    init(account : Account, category : Category , date : Date , amount : Double) {
        self.account = account
        self.category = category
        self.date = date
        self.amount = amount
    }
    

}








