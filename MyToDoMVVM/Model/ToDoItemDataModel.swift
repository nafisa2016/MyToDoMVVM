//
//  ToDoItemDataModel.swift
//  MyToDoMVVM
//
//  Created by Nafisa Rahman on 12/16/17.
//  Copyright © 2017 com.nafisa. All rights reserved.
//

import Foundation

//MARK:- Data Model for a single item
class ToDoItemDataModel {
    
    var title: String
    var done: Bool
    
    init(title: String,done:Bool){
        
        self.title = title
        self.done = done
        
    }
    
    convenience init(title: String){
        
        self.init(title: title,done: false)
        
    }
}
