//
//  AccountTableViewCell.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-18.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var labelBankName: UILabel!
    @IBOutlet weak var labelAccountName: UILabel!
    @IBOutlet weak var labelAccountNumber: UILabel!
    
    
    
    func fillAccountCell(account : AccountR) {
        labelBalance.text = String(account.balance) + "$"
        labelBankName.text = account.bankName
        labelAccountName.text = account.accountName
        labelAccountNumber.text = account.accountNumber
    }
    
}
