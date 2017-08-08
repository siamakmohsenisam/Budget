//
//  ReportViewController.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-18.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import UIKit
import RealmSwift

class ReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldFromDate: UITextField!
    @IBOutlet weak var textFieldToDate: UITextField!
    @IBOutlet weak var textFieldAccount: UITextField!
    @IBOutlet weak var textFieldCategory: UITextField!
    
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    var objects = [Results<BudgetR>]()
    var categoryObjects = [Results<CategoryR>]()
    var accountObjects = [Results<AccountR>]()
    var string = ""
    var dateFormatter = DateFormatter()
    
    var category : CategoryR? = nil
    var account : AccountR? = nil
    var from : Date? = nil
    var to : Date? = nil
    
    let databaseManagerR = DatabaseManagerR.sharedInstance
    
    @IBAction func switchAccount(_ sender: UISwitch) {
        if !(sender.isOn) {
            textFieldAccount.text = ""
            textFieldAccount.isEnabled = false
            account = nil
        }
        if (sender.isOn) {
            textFieldAccount.isEnabled = true
            account = nil
        }
        newQueryReport()
        
    }
    @IBAction func switchCategory(_ sender: UISwitch) {
        if !(sender.isOn) {
            textFieldCategory.text = ""
            textFieldCategory.isEnabled = false
            category = nil
        }
        if (sender.isOn) {
            textFieldCategory.isEnabled = true
            category = nil
        }
        newQueryReport()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        datePicker.datePickerMode = .date
        dateFormatter.dateStyle = .long

        textFieldFromDate.inputView = datePicker
        textFieldToDate.inputView = datePicker
        textFieldAccount.inputView = pickerView
        textFieldCategory.inputView = pickerView
        
        textFieldFromDate.addTarget(self, action: #selector(newQueryReport), for: .editingDidEnd)
        textFieldToDate.addTarget(self, action: #selector(newQueryReport), for: .editingDidEnd)
        textFieldAccount.addTarget(self, action: #selector(newQueryReport), for: .editingDidEnd)
        textFieldCategory.addTarget(self, action: #selector(newQueryReport), for: .editingDidEnd)
        
        
        let barButtonDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneMethod))
        let barButtonSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButtonCancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelMethod))
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([barButtonDone, barButtonSpace, barButtonCancel], animated: false)
        
        textFieldFromDate.inputAccessoryView = toolbar
        textFieldToDate.inputAccessoryView = toolbar
        textFieldAccount.inputAccessoryView = toolbar
        textFieldCategory.inputAccessoryView = toolbar
        
        // load table budget
       newQueryReport()
        databaseManagerR.read(CategoryR.self, complition: {
            (categories) in
            categoryObjects.insert(categories, at: 0)
        })
        
        databaseManagerR.read(AccountR.self, complition: {
            (accounts) in
            accountObjects.insert(accounts, at: 0)
        })

        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func newQueryReport() {
        if let myFrom = textFieldFromDate.text  {
            from = dateFormatter.date(from: myFrom)
        }
        if let myTo = textFieldToDate.text  {
            to = dateFormatter.date(from: myTo)
        }
        if textFieldAccount.text == "" { account = nil }
        if textFieldCategory.text == "" { category = nil }

        
        databaseManagerR.read(BudgetR.self, from: from, to: to, account: account, category: category, complition: {
            
            (bugets) in
            objects.removeAll()
            objects.insert(bugets, at: 0)
            tableView.reloadData()
            
        })

        
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects[section].count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportIdentifierCell", for: indexPath)
        
        if let myCell = cell as? ReportTableViewCell {
            myCell.fillBudgetCell(budget: objects[indexPath.section][indexPath.row])
        }
        
        
        return cell
    }
    
    // MARK: picker view method
    
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
            return string
        }
        else if textFieldCategory.isEditing {
            string = categoryObjects[component][row].categoryName
            return string
        }
        return ""
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if textFieldAccount.isEditing {
            textFieldAccount.text = string
            account = AccountR()
            account = accountObjects[component][row]
            return
        }
        else if textFieldCategory.isEditing {
            textFieldCategory.text = string
            category = CategoryR()
            category = categoryObjects[component][row]
            return
        }
        
    }
    

    
    
    func doneMethod() {
        
        if textFieldFromDate.isEditing {
            textFieldFromDate.text = dateFormatter.string(from: datePicker.date)
        }
        else if textFieldToDate.isEditing {
            textFieldToDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
        
    }
    func cancelMethod() {
        
        if textFieldFromDate.isEditing {
            textFieldFromDate.text = ""
            
        }
        else if textFieldToDate.isEditing {
            textFieldToDate.text = ""
        }
        else if textFieldAccount.isEditing {
            textFieldAccount.text = ""
        }
        else if textFieldCategory.isEditing {
            textFieldCategory.text = ""
        }

        self.view.endEditing(true)
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
