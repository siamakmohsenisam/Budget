//
//  BudgetTableViewController.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-18.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import UIKit
import RealmSwift

class BudgetTableViewController: UITableViewController {

    var objects = [Results<BudgetR>]()
    
    let databaseManagerR = DatabaseManagerR.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showPopup(_:)))
        
        navigationItem.rightBarButtonItem = addButton

        databaseManagerR.read(BudgetR.self, complition: {
            (budgets) in
            objects.insert(budgets, at: 0)
            tableView.reloadData()
            
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func showPopup(_ sender: Any) {
        
        
        let budgetPopupViewController = storyboard?.instantiateViewController(withIdentifier: "BudgetPopupStoryboard") as! BudgetPopupViewController
        present(budgetPopupViewController , animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetIdentifierCell", for: indexPath)

        if let myCell = cell as? BudgetTableViewCell {
            myCell.fillBudgetCell(budget: objects[indexPath.section][indexPath.row])
        }
        

        return cell
    }
 
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete", handler: { (action , indexPath) in
            
            let objectForDelete = self.objects[indexPath.section][indexPath.row]
            
            // Alert
            
            let alert = UIAlertController(title: "Warning", message: "are you sure ?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                (myAction) in
                self.databaseManagerR.deleteItem(object: objectForDelete)
                self.tableView.reloadData()
            })
            alert.addAction(okAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                (myAction) in
                self.tableView.reloadData()
            })
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        })

        
        let edit = UITableViewRowAction(style: .normal, title: "Edit", handler: { (action , indexPath) in
           
            let budgetPopupViewController = self.storyboard?.instantiateViewController(withIdentifier: "BudgetPopupStoryboard") as! BudgetPopupViewController
            
            let objectForEdit = self.objects[indexPath.section][indexPath.row]

            budgetPopupViewController.budgetEdit = objectForEdit
            budgetPopupViewController.isEdit = true
            self.present(budgetPopupViewController , animated: true, completion: nil)

        })
        
        delete.backgroundColor = UIColor.red
        edit.backgroundColor = UIColor.blue
        
        
        return [delete, edit]
    }


 /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
*/
}
