//
//  ToDoItemDataModelTests.swift
//  MyToDoMVVMTests
//
//  Created by Nafisa Rahman on 12/18/17.
//  Copyright © 2017 com.nafisa. All rights reserved.
//

import XCTest
@testable import MyToDoMVVM

class ToDoItemDataModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testToDOItemModel() {
        
        let toDoItem = ToDoItemDataModel(title: "shopping", done: false)
        
        XCTAssertEqual(toDoItem.title, "shopping", "ToDo Item title is not initialized correctly")
        XCTAssertEqual(toDoItem.done, false, "TODO Item done is not initialized correctly")
    }
    
    func testConVenienceInit(){
        
        let toDoItem1: ToDoItemDataModel = ToDoItemDataModel(title: "work")
        let toDOItem2 : ToDoItemDataModel = ToDoItemDataModel(title: "work", done: false)
        
        XCTAssertEqual(toDoItem1.title, toDOItem2.title, "init not correct")
        XCTAssertEqual(toDoItem1.done, toDOItem2.done, "init not correct")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
