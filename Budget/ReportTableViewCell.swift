//
//  ReportTableViewCell.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-27.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    
    @IBOutlet weak var amountLable: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var dateFormatter = DateFormatter()
    
    func fillBudgetCell(budget : BudgetR) {
        amountLable.text = String(budget.amount) + "$"
        accountLabel.text = budget.account?.accountName
        categoryLabel.text = budget.category?.categoryName
        dateFormatter.dateStyle = .long
        dateLabel.text = dateFormatter.string(from: budget.date)
        
    }
   
    
    
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
