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
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
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
    
    func testInsert() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
        
//        let exists = sut.checkItemExist(title: "ppp")
//
//        XCTAssertEqual(exists, true, "item doesn't exist")
        
        let allItems = sut.fetchAllItems()
        
        XCTAssertEqual(allItems.count, 4, "count incorrect")
        
    }
    
//    func testItem(){
//
//        let exists = sut.checkItemExist(title: "pp")
//
//        XCTAssertEqual(exists, true, "item doesn't exist")
//    }
//
//    func testFetchAll(){
//
//        let allItems = sut.fetchAllItems()
//
//        XCTAssertEqual(allItems.count, 1, "count incorrect")
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
