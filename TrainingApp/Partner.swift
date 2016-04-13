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
//    dynamic var userName: String?
//    dynamic var email: String?
//    dynamic var address: String?
//    dynamic var phone: String?
//    dynamic var website: String?


    override init() {
    }
    
    init(name: String, company: String) {
        self.name = name
        self.company = company
    }
    
    static func kinveyCollectionName() -> String {
        return "Partner"
    }
    
    static func kinveyPropertyMapping() -> [String : String] {
        return [
            "objectId" : Kinvey.PersistableIdKey,
            "name" : "partnername",
            "company" : "partnercompany",
//            "userName" : "username",
//            "email" : "email",
//            "address" : "address",
//            "phone" : "phone",
//            "website" : "website"
        ]
    }
    
}
