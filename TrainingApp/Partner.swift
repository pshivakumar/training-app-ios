//
//  Partner.swift
//  TrainingApp
//
//  Created by Victor Barros on 2016-02-08.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import Foundation
import Kinvey

class Partner: NSObject, Persistable {
    
    dynamic var objectId: String?
    dynamic var name: String?
    dynamic var company: String?
    
    override init() {
    }
    
    init(name: String) {
        self.name = name
    }
    
    static func kinveyCollectionName() -> String {
        return "partner"
    }
    
    static func kinveyPropertyMapping() -> [String : String] {
        return [
            "objectId" : Kinvey.PersistableIdKey,
            "name" : "partnername",
            "company" : "partnercompany"
        ]
    }
    
}
