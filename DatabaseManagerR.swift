//
//  DatabaseManagerR.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-24.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManagerR : NSObject {
    
    // for Singelton
    
    public static let sharedInstance = DatabaseManagerR()
    private override init(){}
    
    let realm = try? Realm()
    
    public func write(object : Object) {
        
        try? realm?.write {
            if let category = object as? CategoryR {
                
                if let duplicateCategory = realm?.objects(CategoryR.self).filter("categoryName = %@", category.categoryName) {
                    if duplicateCategory.count > 0 {
                        return
                    }
                }
            }
            else if let account = object as? AccountR {
                if let duplicateAccount = realm?.objects(AccountR.self).filter("accountName = %@ AND bankName = %@", account.accountName, account.bankName) {
                    if duplicateAccount.count > 0 {
                        account.id = duplicateAccount[0].id
                        realm?.add(account, update: true)
                        return
                    }
                }
            }
            realm?.add(object, update: true)
        }
    }
    
    public func read <T : Object> (_ model : T.Type ,
                      from : Date? = nil ,
                      to : Date? = nil ,
                      account : AccountR? = nil ,
                      category : CategoryR? = nil ,
                      complition: (Results<T>)-> () )
    {
        var result = realm?.objects(model)
        
        if let dateFrom = from {
            result = result?.filter("date >= %@", dateFrom)
        }
        if let dateTo = to {
            result = result?.filter("date <= %@", dateTo)
        }
        if let myAccount = account {
            result = result?.filter("account.accountName = %@ AND account.bankName = %@", myAccount.accountName, myAccount.bankName)
        }
        if let myCategory = category {
            result = result?.filter("category.categoryName = %@", myCategory.categoryName)
        }
        
        if let res = result {
            complition(res)
        }
    }
    
    public func deleteItem<T : Object>(object : T){
        try? realm?.write {
            realm?.delete(object)
        }
    }
    
    public func deleteAll(){
        try? realm?.write {
            realm?.deleteAll()
        }
    }
    
}











