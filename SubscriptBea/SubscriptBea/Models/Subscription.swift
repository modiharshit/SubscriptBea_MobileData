//
//  Subscription.swift
//  SubscriptBea
//
//  Created by Harshit on 06/12/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Subscription: NSObject, Mappable, NSCopying, NSCoding {
    
    // MARK: Properties
    
    var id: String?
    var subscriptionTitle: String?
    var subscriptionType: String?
    var subscriptionAmount: String?
    var subscriptionStartDate: String?
    
    init(id: String?, subscriptionTitle: String?, subscriptionType: String?, subscriptionAmount: String?, subscriptionStartDate: String?) {
        self.id = id
        self.subscriptionTitle = subscriptionTitle
        self.subscriptionType = subscriptionType
        self.subscriptionAmount = subscriptionAmount
        self.subscriptionStartDate = subscriptionStartDate
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Subscription(id: id, subscriptionTitle: subscriptionTitle, subscriptionType: subscriptionType, subscriptionAmount: subscriptionAmount, subscriptionStartDate: subscriptionStartDate)
    }
    
    override init() {
        self.id = nil
        self.subscriptionTitle = nil
        self.subscriptionType = nil
        self.subscriptionAmount = nil
        self.subscriptionStartDate = nil
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
        id <- map["id"]
        subscriptionTitle <- map["title"]
        subscriptionType <- map["type"]
        subscriptionAmount <- map["amount"]
        subscriptionStartDate <- map["startDate"]
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "_id") as? String
        self.subscriptionTitle = aDecoder.decodeObject(forKey: "subscriptionTitle") as? String
        self.subscriptionType = aDecoder.decodeObject(forKey: "subscriptionType") as? String
        self.subscriptionAmount = aDecoder.decodeObject(forKey: "subscriptionAmount") as? String
        //self.subscriptionStartDate = aDecoder.decodeObject(forKey: "subscriptionStartDate") as? Date
        
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "_id")
        aCoder.encode(subscriptionTitle, forKey: "subscriptionTitle")
        aCoder.encode(subscriptionType, forKey: "subscriptionType")
        aCoder.encode(subscriptionAmount, forKey: "subscriptionAmount")
        aCoder.encode(subscriptionStartDate, forKey: "subscriptionStartDate")
        
    }
}

