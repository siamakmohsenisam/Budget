//
//  Account.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-17.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import Foundation


class Account {
    
    var accountName : String
    var accountNumber : String
    var bankName : String
    var balance : Double
    
    convenience init() {
        self.init(accountName: "", accountNumber: "", bankName: "", balance: 0.0)
    }
    init (accountName : String, accountNumber : String , bankName : String , balance : Double ){
        
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.bankName = bankName
        self.balance = balance        
    }
}
