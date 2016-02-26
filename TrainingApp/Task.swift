//
//  Task.swift
//  TrainingApp
//
//  Created by Victor Barros on 2016-02-08.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import Foundation
import Kinvey

class Task: NSObject, Persistable {
    
    dynamic var objectId: String?
    dynamic var action: String?
    dynamic var dueDate: String?
    dynamic var completed: Bool

    override init() {
        completed = false
    }
    
    static func kinveyCollectionName() -> String {
        return "todo"
    }
    
    static func kinveyPropertyMapping() -> [String : String] {
        return [
            "objectId"  : Kinvey.PersistableIdKey,
            "action"    : "action",
            "dueDate"   : "duedate",
            "completed" : "completed",
        ]
    }
    
}
