//
//  ToDoTableViewController.swift
//  MyToDoMVVM
//
//  Created by Nafisa Rahman on 12/16/17.
//  Copyright © 2017 com.nafisa. All rights reserved.
//

import UIKit
import CoreData

protocol HandleUI : class {
    func showItemEXistsAlert()
}

class ToDoTableViewController: UITableViewController {
    
    lazy var toDOListViewModel  = ToDoListViewModel(context:  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegate
        toDOListViewModel.handleUIDelegate = self
        
        //MARK:- large title
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.topItem?.title = "To Do"
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        } else {
            navigationController?.navigationBar.topItem?.title = "To Do"
        }
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //MARK:- get data from core data
        toDOListViewModel.getList()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    //MARK: no of section
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return toDOListViewModel.getSection()
    }
    
    //MARK: no of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDOListViewModel.getItems()
    }
    
    //MARK:- configure a cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = toDOListViewModel.getRowDataTitle(row: indexPath.row)
        
        let accessory: UITableViewCellAccessoryType = toDOListViewModel.getRowDataDone(row: indexPath.row) ? .checkmark : .none
        cell.accessoryType = accessory
        
        return cell
    }
    
    //MARK:- add an item
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        // Create an alert
        let alert = UIAlertController(
            title: "New to-do item",
            message: "Insert the title of the new to-do item:",
            preferredStyle: .alert)
        
        // Add a text field to the alert for the new item's title
        alert.addTextField(configurationHandler: nil)
        
        // Add a "cancel" button to the alert. This one doesn't need a handler
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add a "OK" button to the alert. The handler calls addNewToDoItem()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text
            {
                // self.addNewToDoItem(title: title)
                let inserted = self.toDOListViewModel.addItem(title: title)
                
                if inserted {
                    self.tableView.insertRows(at: [IndexPath(row: self.toDOListViewModel.getItems() - 1, section: 0)], with: .top)
                }
                
            }
        }))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK:- update an item
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < toDOListViewModel.getItems()
        {
            toDOListViewModel.setRowDataDone(row:indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    //MARK:- delete an item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if indexPath.row < toDOListViewModel.getItems()
        {
            toDOListViewModel.deleteItem(row: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    
}

extension ToDoTableViewController : HandleUI {
    
    func showItemEXistsAlert(){
        
        // Create an alert
        let alert = UIAlertController(
            title: "Duplicate item",
            message: "Item already exists",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
        
    }
}
