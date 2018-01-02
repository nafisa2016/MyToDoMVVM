//
//  ToDoTableViewControllerTests.swift
//  MyToDoMVVMTests
//
//  Created by Nafisa Rahman on 1/2/18.
//  Copyright © 2018 com.nafisa. All rights reserved.
//

import XCTest
@testable import MyToDoMVVM

class ToDoTableViewControllerTests: XCTestCase {
    
    var toDoTableViewController : ToDoTableViewController!
    var navigation : UINavigationController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        toDoTableViewController = storyboard.instantiateViewController(withIdentifier: "ToDoTableViewController") as! ToDoTableViewController
        
        //set up UIWindow hierarchy
        //UIApplication.shared.keyWindow?.rootViewController = toDoTableViewController
        
        _ = toDoTableViewController.view
        navigation = UINavigationController()
        navigation.viewControllers = [toDoTableViewController]
        
        toDoTableViewController.loadView()
        toDoTableViewController.viewDidLoad()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTableViewExists() {
        
        XCTAssertNotNil(toDoTableViewController.tableView)
    }
    
    func testControllerConformsToProtocol() {
        
        XCTAssert(toDoTableViewController.conforms(to: HandleUI.self), "ViewController under test does not conform to protocol")
    }
    
    func testToDoTableViewControllerHasNavigationController() {
        
        XCTAssertNotNil(toDoTableViewController.navigationController)
    
    }
    
    func testToDoTableViewControllerBarButton(){
        XCTAssertNotNil(toDoTableViewController.navigationController?.navigationBar.topItem?.rightBarButtonItem)
       
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
