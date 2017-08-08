//
//  AccountPopupViewController.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-17.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import UIKit

class AccountPopupViewController: UIViewController {

  
    @IBOutlet weak var textFieldAccountName: UITextField!
    @IBOutlet weak var textFieldAccountNumber: UITextField!
    @IBOutlet weak var textFieldBankName: UITextField!
    @IBOutlet weak var textFieldBalance: UITextField!
    
    let databaseManagerR = DatabaseManagerR.sharedInstance
    var accountTableViewController = AccountTableViewController()
    
    var isEdit = false
    var accountEdit = AccountR()
    var account = AccountR()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let views = presentingViewController?.childViewControllers {
            for view in views {
                if view as? AccountTableViewController != nil {
                    accountTableViewController = view as! AccountTableViewController
                    break
                }
            }
        }
        
        if isEdit {
            textFieldAccountName.text = accountEdit.accountName
            textFieldAccountNumber.text = accountEdit.accountNumber
            textFieldBankName.text = accountEdit.bankName
            textFieldBalance.text = String(accountEdit.balance)
        }
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonSaveAndCancel(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            dismiss(animated: true, completion: nil)
            break
        case 2:
            
            guard let accountName = textFieldAccountName.text ,
                   let accountNumber = textFieldAccountNumber.text,
                let bankName = textFieldBankName.text ,
                let balance = textFieldBalance.text else { return  }
            
            guard textFieldAccountName.text != "" else {  return }
            guard textFieldAccountNumber.text != "" else {  return }
            guard textFieldBankName.text != "" else {  return }
            guard textFieldBalance.text != "" else {  return }

            
            
            
            let aName  = accountName.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
            let aNumber  = accountNumber.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
            let bName  = bankName.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
            
            account = AccountR(value: [
                "accountName" : aName ,
                "accountNumber" : aNumber,
                "bankName" : bName ,
                "balance" : Double(balance) ?? 0])
            
            if isEdit {
                account.id = accountEdit.id
                isEdit = false
            }
            databaseManagerR.write(object: account)
            accountTableViewController.tableView.reloadData()
            dismiss(animated: true, completion: nil)
            break
            //
        default:
            break
        }
    }

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
