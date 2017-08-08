//
//  CategoryPopupViewController.swift
//  Budget
//
//  Created by Siamak Mohseni Sam on 2017-07-17.
//  Copyright © 2017 Siamak Mohseni Sam. All rights reserved.
//

import UIKit

class CategoryPopupViewController: UIViewController {

    @IBOutlet weak var textFieldCategoryName: UITextField!
    
    let databaseManagerR = DatabaseManagerR.sharedInstance
    var categoryTableViewController = CategoryTableViewController()
    var category = CategoryR()
    var isEdit = false
    var categoryName = ""
    var categoryId = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let views = presentingViewController?.childViewControllers {
            
            for view in views {
                if view as? CategoryTableViewController != nil {
                    categoryTableViewController = view as! CategoryTableViewController
                    break
                }
            }
        }
        
        if isEdit == true {
            textFieldCategoryName.text = categoryName
            category.id = categoryId
            isEdit = false
        }

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButten(_ sender: UIButton) {
    
        guard let name = textFieldCategoryName.text else {
            return
        }
        guard textFieldCategoryName.text != "" else {  return }
        
        category.categoryName = name.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
        
        databaseManagerR.write(object: category)
        categoryTableViewController.tableView.reloadData()
        dismiss(animated: true, completion: nil)
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
