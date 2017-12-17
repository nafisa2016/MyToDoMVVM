//
//  ToDoListViewModel.swift
//  MyToDoMVVM
//
//  Created by Nafisa Rahman on 12/16/17.
//  Copyright © 2017 com.nafisa. All rights reserved.
//

import Foundation

protocol GetListOperation {
    func getList()
    func getRowDataTitle(row: Int)->String
    func getRowDataDone(row: Int)->Bool
    func getSection() -> Int
    func getItems()->Int
    func addItem(title: String)-> Bool
    func deleteItem(row: Int)
}

class ToDoListViewModel  {
    
    //MARK:- all list items
    private var myList: [ToDoItemDataModel] = []
    
    //core data handler delegate
    weak var coreDatahandlerDelegate: CoreDataHandlerProtocol? = nil
    let coreDataHandler = CoreDataHandler()
    
    //UI handler delegate
    weak var handleUIDelegate: HandleUI? = nil
    
}

extension ToDoListViewModel : GetListOperation {
    
    //MARK:- Get all list items from Core Data
    func getList() {
        
        //fetch all data from core data
        let fetchedItems = coreDataHandler.fetchAllItems()
        
        for each in fetchedItems {
            myList.append(ToDoItemDataModel(title: each.title!, done: each.done))
        }
        
    }
    
    //MARK:- Get title for an item
    func getRowDataTitle(row: Int)->String {
        return (myList[row].title )
    }
    
    //MARK:- Get done for an item
    func getRowDataDone(row: Int)->Bool {
        return (myList[row].done )
    }
    
    //MARK:- Update done
    func setRowDataDone(row:Int){
        
        myList[row].done = !myList[row].done
        
        //set delegate
        self.coreDatahandlerDelegate = coreDataHandler
        
        //update core data
        coreDatahandlerDelegate?.updateItem(title: myList[row].title, done: myList[row].done)
    }
    
    //MARK:- get section
    func getSection() -> Int {
        return 1
    }
    
    //MARK:- get items
    func getItems()->Int {
        return myList.count  
    }
    
    //MARK:- Add an item
    func addItem(title: String) -> Bool{
        
        //set delegate
        self.coreDatahandlerDelegate = coreDataHandler
        
        //insert into CoreData
        let inserted = coreDatahandlerDelegate?.insertItem(title: title, done: false)
        
        if !inserted! {
            //show alert
            handleUIDelegate?.showItemEXistsAlert()
            return false
        }else {
            myList.append(ToDoItemDataModel(title: title,done: false))
            return true
        }
        
    }
    
    //MARK:- Delete an item
    func deleteItem(row: Int){
        
        //set delegate
        self.coreDatahandlerDelegate = coreDataHandler
        
        //delete from core data
        coreDatahandlerDelegate?.deleteItem(title: myList[row].title)
        
        myList.remove(at: row)
    }
    
}
