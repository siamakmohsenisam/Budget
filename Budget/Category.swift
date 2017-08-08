//
//  Category.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-17.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import Foundation

class Category {
    
    var categoryName : String
    
    convenience init(){
        self.init(categoryName: "")
    }
    
    init(categoryName : String) {
        self.categoryName = categoryName
    }
}
