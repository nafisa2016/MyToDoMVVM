//
//  CoreDataHandlerTests.swift
//  MyToDoMVVMTests
//
//  Created by Nafisa Rahman on 12/18/17.
//  Copyright © 2017 com.nafisa. All rights reserved.
//

import XCTest
@testable import MyToDoMVVM
import CoreData

class CoreDataHandlerTests: XCTestCase {
    
    var sut: CoreDataHandler!
    
    var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ListCoreDataModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if error
            if let error = error {
                fatalError("error \(error)")
            }
        }
        return container
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let context = mockPersistantContainer.viewContext
        sut = CoreDataHandler(context: context)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testCoreDataOperations() {
        
        //test insert
        var insertResult = sut.insertItem(title: "b1", done: false)
        XCTAssertEqual(insertResult, true, "Not inserted")
        
        insertResult = sut.insertItem(title: "b2", done: false)
        XCTAssertEqual(insertResult, true, "Not inserted")
        
        insertResult = sut.insertItem(title: "b3", done: false)
        XCTAssertEqual(insertResult, true, "Not inserted")
        
        insertResult = sut.insertItem(title: "b4", done: false)
        XCTAssertEqual(insertResult, true, "Not inserted")
        
        insertResult = sut.insertItem(title: "b5", done: false)
        XCTAssertEqual(insertResult, true, "Not inserted")
        
        //test fetch all
        var allItems = sut.fetchAllItems()
        XCTAssertEqual(allItems.count, 5, "count incorrect")
        
        //test delete
        sut.deleteItem(title: "b5")
        allItems = sut.fetchAllItems()
        XCTAssertEqual(allItems.count, 4, "count incorrect")
        
        //test update
        sut.updateItem(title: "b4", done: true)
        
        
    }
    

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
