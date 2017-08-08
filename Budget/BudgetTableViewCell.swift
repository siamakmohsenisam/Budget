//
//  BudgetTableViewCell.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-18.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {

  
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var labelAccountName: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    var dateFormatter = DateFormatter()
    
    func fillBudgetCell(budget : BudgetR) {
        labelAmount.text = String(budget.amount) + "$"
        labelAccountName.text = budget.account?.accountName
        labelCategory.text = budget.category?.categoryName
        dateFormatter.dateStyle = .long
        labelDate.text = dateFormatter.string(from: budget.date)
        
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
