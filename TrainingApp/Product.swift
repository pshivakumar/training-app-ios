//
//  Product.swift
//  TrainingApp
//
//  Created by Victor Barros on 2016-02-08.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import Foundation
import Kinvey

class Product: NSObject, Persistable {
    
    dynamic var objectId: String?
    dynamic var name: String?
    dynamic var productDescription: String?
    
    override init() {
    }
    
    init(name: String) {
        self.name = name
    }
    
    static func kinveyCollectionName() -> String {
        return "vProducts"
    }
    
    static func kinveyPropertyMapping() -> [String : String] {
        return [
            "objectId" : Kinvey.PersistableIdKey,
            "name" : "productname",
            "productDescription" : "productdesc"
        ]
    }
    
}
