//
//  CoreDataHandler.swift
//  MyToDoMVVM
//
//  Created by Nafisa Rahman on 12/17/17.
//  Copyright © 2017 com.nafisa. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc protocol CoreDataHandlerProtocol: class {
    
    func insertItem(title: String,done:Bool) -> Bool
    func fetchAllItems()-> [Item]
    func updateItem(title: String,done: Bool)
    func deleteItem(title: String)
}

class CoreDataHandler: CoreDataHandlerProtocol {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    
    //MARK:- insert an item
    func insertItem(title: String,done:Bool) -> Bool{
        
        if checkItemExist(title: title) {
            //show alert
            return false
        }else {
            
            let item = Item(context: context)
            item.title = title
            item.done = done
            
            do {
                try context.save()
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        return true
    }
    
    func checkItemExist(title: String)->Bool {
        
        var exists = false
        
        let fetchedRequest = NSFetchRequest<Item>(entityName: "Item")
        
        fetchedRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let fetchedRecord = try context.fetch(fetchedRequest)
            
            if fetchedRecord.count > 0 {
                exists = true
            }else{
                exists =  false
            }
        }
        catch {
            print("fetch error while checking duplicate")
        }
        
        return exists
        
    }
    
    //MARK:- fetch all items
    func fetchAllItems() -> [Item]{
        
        var items = [Item]()
        
        do {
            
            let fetchrequest = NSFetchRequest<Item>(entityName: "Item")
            
            let fetchedRecord = try context.fetch(fetchrequest)
            items = fetchedRecord
            
        }catch {
            print("error in fetch")
        }
        
        return items
    }
    
    //MARK:- update an item
    func updateItem(title: String,done: Bool){
        
        let fetchedRequest = NSFetchRequest<Item>(entityName: "Item")
        
        fetchedRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let fetchedRecord = try context.fetch(fetchedRequest)
            
            for item in fetchedRecord {
                
                item.title = title
                item.done = done
                
            }
            
            do {
                try context.save()
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
        catch {
            print("fetch error while updating")
        }
        
        
    }
    
    //MARK:- delete an item
    func deleteItem(title: String){
        
        let fetchedRequest = NSFetchRequest<Item>(entityName: "Item")
        
        fetchedRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let fetchedRecord = try context.fetch(fetchedRequest)
            
            for item in fetchedRecord {
                context.delete(item)
            }
            
            do {
                try context.save()
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
        catch {
            print("fetch error while deleting")
        }
        
    }
    
    
}
