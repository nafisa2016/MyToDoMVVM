//
//  MyToDoMVVMUITests.swift
//  MyToDoMVVMUITests
//
//  Created by Nafisa Rahman on 12/16/17.
//  Copyright © 2017 com.nafisa. All rights reserved.
//

import XCTest

class MyToDoMVVMUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testToDoViewControllerTitle(){
        
        XCTAssert(app.navigationBars["To Do"].exists)
    }
    
    func testToDoViewControllerAddButton(){
        
        XCTAssert(app.navigationBars["To Do"].buttons["Add"].exists)
    }
    
    func testToDoTableExists(){
        
        let table = app.tables.element
        XCTAssertTrue(table.exists)
    }
    
    func testDeleteItem(){
        
        let addButton = app.navigationBars["To Do"].buttons["Add"]
        addButton.tap()
        
        let newToDoItemAlert = app.alerts["New To Do item"]
        let textField = newToDoItemAlert.collectionViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.typeText("a")
        
        let okButton = newToDoItemAlert.buttons["OK"]
        okButton.tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["a"].swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        XCTAssert(app.tables.cells.count == 0)
        
    }
    
    func testDuplicateItemAlert(){
        
        let addButton = app.navigationBars["To Do"].buttons["Add"]
        addButton.tap()
        
        let newToDoItemAlert = app.alerts["New To Do item"]
        let textField = newToDoItemAlert.collectionViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.typeText("a")
        
        let okButton = newToDoItemAlert.buttons["OK"]
        okButton.tap()
        
        XCTAssertNotNil(app.alerts["Duplicate item"].exists)
        
        //app.alerts["Duplicate item"].buttons["OK"].tap()
    }
    
    func testInsertToDoItem(){
        
        let addButton = app.navigationBars["To Do"].buttons["Add"]
        addButton.tap()
        
        let newToDoItemAlert = app.alerts["New To Do item"]
        let textField = newToDoItemAlert.collectionViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.typeText("a")
        
        let okButton = newToDoItemAlert.buttons["OK"]
        okButton.tap()
        
        XCTAssertNotNil(app.tables.staticTexts["a"].exists)
        
    }
    
    func testUpdateItem(){
        
        app.navigationBars["To Do"].buttons["Add"].tap()
        
        let newToDoItemAlert = app.alerts["New To Do item"]
    newToDoItemAlert.collectionViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText("a")
        newToDoItemAlert.buttons["OK"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["a"].tap()
        
        XCTAssertNotNil(tablesQuery.buttons["More Info"].exists)
    }
}
