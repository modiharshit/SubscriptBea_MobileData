//
//  User.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 30/06/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit
import ObjectMapper

class User: NSObject, Mappable, NSCopying, NSCoding {
    
    // MARK: Properties
    
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var profilePicture: String?
    
    init(id: String?, firstName: String?, lastName: String?, email: String?, profilePicture: String?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profilePicture = profilePicture
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return User(id: id, firstName: firstName, lastName: lastName, email: email, profilePicture: profilePicture)
    }
    
    override init() {
        self.id = nil
        self.firstName = nil
        self.lastName = nil
        self.email = nil
        self.profilePicture = nil
    }
    
    // MARK: ObjectMapper Initalizers
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    required public init?(map: Map){
        
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {
        id <- map["_id"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        email <- map["email"]
        profilePicture <- map["profilePicture"]
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "_id") as? String
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.profilePicture = aDecoder.decodeObject(forKey: "profilePicture") as? String
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "_id")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(profilePicture, forKey: "profilePicture")
    }
}

