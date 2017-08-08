//
//  MyPattern.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-17.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import Foundation

public enum MyPattern : String {
    
    case CellPhone = "^\\+\\d{1,}\\(\\d{3}\\)\\d{3}-\\d{4}$"
    case Email = "^.+@.+\\..+$"
    case Word = "^[a-zA-Z_]*$"
    case UserName = "^\\w*$"
    case Date = "^(\\d{3,4})-([0][1-9]|[1-9]|[1][0-2])-([1-9]|[0][1-9]|[1-2][0-9]|[3][0-1])$"
    case IntegerNumber = "^\\d+$"
    case DecimalNumber = "(^\\-{0,1}\\d+$)|(^\\-{0,1}\\d+\\.\\d+$)"

    }
