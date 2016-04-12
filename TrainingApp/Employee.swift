//
//  Employee.swift
//  TrainingApp
//
//  Created by Vladislav Krasovsky on 4/12/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import Foundation
import Kinvey

class Employee: NSObject, Persistable {
    
    dynamic var objectId: String?
    dynamic var name: String?
    
    override init() {
    }
    
    init(name: String) {
        self.name = name
    }
    
    static func kinveyCollectionName() -> String {
        return "Employees"
    }
    
    static func kinveyPropertyMapping() -> [String : String] {
        return [
            "objectId" : Kinvey.PersistableIdKey,
            "name" : "name"
        ]
    }
    
}