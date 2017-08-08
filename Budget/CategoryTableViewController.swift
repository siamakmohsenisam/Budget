//
//  CategoryTableViewController.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-17.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    //   var categoryPopupViewController : CategoryPopupViewController? = nil
    
    var objects : [Results<CategoryR>] = []
    
    let databaseManagerR = DatabaseManagerR.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showPopup))
        navigationItem.rightBarButtonItem = addButton
        
        databaseManagerR.read(CategoryR.self, complition: {
            
            (categories) in
            
            objects.insert(categories, at: 0)
            tableView.reloadData()
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    func showPopup() {
        
        let categoryPopupViewController = storyboard?.instantiateViewController(withIdentifier: "CategoryPopupStoryboard") as! CategoryPopupViewController
        present(categoryPopupViewController, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryIdentifierCell", for: indexPath)
        
        let object = objects[indexPath.section][indexPath.row]
        cell.textLabel?.text = object.categoryName
        // Configure the cell...
        
        return cell
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete", handler: { (action , indexPath) in
            
            let objectForDelete = self.objects[indexPath.section][indexPath.row]
            
            self.databaseManagerR.read(BudgetR.self, complition: {
                
                (budgets) in
                
                for obj in budgets {
                    if obj.category?.categoryName == objectForDelete.categoryName {
                        self.databaseManagerR.deleteItem(object: obj)
                    }
                }
            })
            
            // Alert
            
            let alert = UIAlertController(title: "Warning", message: "If you delete this row then it will be deleted from Budget table automaticlly (if used there)", preferredStyle: .alert)
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
            
            let objectForEdit = self.objects[indexPath.section][indexPath.row]
            
            let categoryPopupViewController = self.storyboard?.instantiateViewController(withIdentifier: "CategoryPopupStoryboard") as! CategoryPopupViewController
            
            categoryPopupViewController.isEdit = true
            categoryPopupViewController.categoryName = objectForEdit.categoryName
            categoryPopupViewController.categoryId = objectForEdit.id

            
            self.present(categoryPopupViewController, animated: true, completion: nil)
            
            
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
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
