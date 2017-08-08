//
//  BudgetViewController.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-18.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import UIKit
import RealmSwift

class BudgetPopupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var textFieldDate: UITextField!
    @IBOutlet weak var textFieldAmount: UITextField!
    @IBOutlet weak var textFieldAccount: UITextField!
    @IBOutlet weak var textFieldCategory: UITextField!
    
    
    let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    
    var categoryObjects = [Results<CategoryR>]()
    var accountObjects = [Results<AccountR>]()
    
    var string = ""
    var category = CategoryR()
    var account = AccountR()
    let budget = BudgetR()
    var budgetEdit = BudgetR()
    var account2 = AccountR()
    var isEdit = false
    
    
    let dateFormater = DateFormatter()
    let databaseManagerR = DatabaseManagerR.sharedInstance
    
    var budgetTableViewController = BudgetTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        datePicker.datePickerMode = .date
        dateFormater.dateStyle = .long
        
        
        textFieldDate.inputView = datePicker
        textFieldAccount.inputView = pickerView
        textFieldCategory.inputView = pickerView
        
        let barButtonDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneMethod))
        let barButtonSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButtonCancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelMethod))
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([barButtonDone, barButtonSpace, barButtonCancel], animated: false)
        
        textFieldDate.inputAccessoryView = toolbar
        textFieldAccount.inputAccessoryView = toolbar
        textFieldCategory.inputAccessoryView = toolbar
        
        databaseManagerR.read(CategoryR.self, complition: {
            (categories) in
            categoryObjects.insert(categories, at: 0)
        })
        
        databaseManagerR.read(AccountR.self, complition: {
            (accounts) in
            accountObjects.insert(accounts, at: 0)
        })
        
        if let views = presentingViewController?.childViewControllers{
            for view in views {
                print(views.count)
                if let v = view as? BudgetTableViewController {
                    budgetTableViewController = v
                }
            }
        }
        
        if isEdit {
            textFieldDate.text = dateFormater.string(from: budgetEdit.date)
            textFieldAmount.text = String(budgetEdit.amount)
            if let accountEdit = budgetEdit.account {
                string = "\(accountEdit.bankName)  \(accountEdit.accountName) : \(accountEdit.balance)$"
                account = accountEdit
                account2.id = accountEdit.id
            }
            textFieldAccount.text = string
            if let categoryEdit = budgetEdit.category {
                string = "\(categoryEdit.categoryName)"
                category = categoryEdit
            }
            textFieldCategory.text = string
            
            budget.id = budgetEdit.id
            isEdit = false
        }
    }
    
    // MARK: picker method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if textFieldAccount.isEditing {
            return accountObjects[component].count
        }
        else if textFieldCategory.isEditing {
            return categoryObjects[component].count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if textFieldAccount.isEditing {
            string = "\(accountObjects[component][row].bankName)  \(accountObjects[component][row].accountName) : \(accountObjects[component][row].balance)$"
            account = accountObjects[component][row]
            return string
        }
        else if textFieldCategory.isEditing {
            category = categoryObjects[component][row]
            string = "\(categoryObjects[component][row].categoryName)"
            return string
        }
        return ""
        
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//        if textFieldAccount.isEditing {
//            account = accountObjects[0][row]
//            return
//        }
//        else if textFieldCategory.isEditing {
//            category = categoryObjects[component][row]
//            return
//        }
//        
//    }
    
    
    func doneMethod() {
        
        
        if textFieldDate.isEditing {
            textFieldDate.text = dateFormater.string(from: datePicker.date)
        }
        else if textFieldAccount.isEditing {
            
            textFieldAccount.text = string
        }
        else if textFieldCategory.isEditing {
            
            textFieldCategory.text = string
        }
        
        
        self.view.endEditing(true)
        
    }
    func cancelMethod() {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func buttonCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func buttonSave(_ sender: UIButton) {
        
        guard let date = textFieldDate.text ,
            let amount = textFieldAmount.text ,
            let _ = textFieldCategory.text ,
            let _ = textFieldAccount.text
            else { return  }
        
        guard textFieldDate.text != "" else {  return }
        guard textFieldAmount.text != "" else {  return }
        guard textFieldCategory.text != "" else {  return }
        guard textFieldAccount.text != "" else {  return }
        
        budget.amount = Double(amount)!
        
        budget.date = dateFormater.date(from: date)!
        budget.account = account
        budget.category = category
        
        
        
        databaseManagerR.write(object: budget)
        
        budgetTableViewController.tableView.reloadData()
        
        calculate()
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func calculate(){
        
        account2.balance = account.balance + budget.amount
        account2.accountName = account.accountName
        account2.accountNumber = account.accountNumber
        account2.bankName = account.bankName
        databaseManagerR.write(object: account2)
        
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
