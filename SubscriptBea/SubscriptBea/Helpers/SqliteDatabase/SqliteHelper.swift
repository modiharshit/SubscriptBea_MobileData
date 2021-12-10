//
//  DBHelper.swift
//  SubscriptBea
//
//  Created by Daksh Upadhyay on 2021-12-09.
//  Copyright © 2021 Daksh Upadhyay. All rights reserved.
//

import Foundation
import SQLite3

class SqliteHelper {
    var db: OpaquePointer?
    var dbPath = "subscriptbea.sqlite"
    
    init(){
        db = createDatabase()
        self.createTableSubscription()
    }
    
    func createDatabase() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(dbPath)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating DB")
            return nil
        }else {
            print("Subscription Database has been created with path \(dbPath)")
            return db
        }
        
    }
    
    func createTableSubscription()  {
        let query = "CREATE TABLE IF NOT EXISTS subscription(id INTEGER PRIMARY KEY AUTOINCREMENT, subscriptionTitle TEXT, subscriptionType TEXT, subscriptionAmount TEXT, subscriptionStartDate TEXT);"
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Subscription Table creation success")
            }else {
                print("Subscription Table creation fail")
            }
        } else {
            print("Subscription Prepration fail")
        }
    }
    
    func insertSubscription(subscriptionTitle : String, subscriptionType: String, subscriptionAmount: String, subscriptionStartDate: String) {
        let query = "INSERT INTO subscription(id, subscriptionTitle, subscriptionType, subscriptionAmount, subscriptionStartDate) VALUES (?, ?, ?, ?, ?);"
        
        var statement : OpaquePointer? = nil
        
        var isEmpty = false
        if getSubscriptionsCount() == 0{
            isEmpty = true
        }
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if isEmpty {
                sqlite3_bind_int(statement, 1, 1)
            }
            sqlite3_bind_text(statement, 2, (subscriptionTitle as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (subscriptionType as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (subscriptionAmount as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, (subscriptionStartDate as NSString).utf8String, -1, nil)
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Subscription Data inserted success")
            }else {
                print("Subscription Data is not inserted in table")
            }
        } else {
            print("Subscription Insert Query is not as per requirement")
        }
        
    }
    
    func getSubscriptions() -> [Subscription]? {
        var subscriptions = [Subscription]()
        
        let query = "SELECT * FROM subscription;"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = String(sqlite3_column_int(statement, 0))
                let subscriptionTitle = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                let subscriptionType = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                let subscriptionAmount = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                let subscriptionStartDate = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                let model = Subscription()
                model.id = id
                model.subscriptionTitle = subscriptionTitle
                model.subscriptionType = subscriptionType
                model.subscriptionAmount = subscriptionAmount
                model.subscriptionStartDate = subscriptionStartDate
                
                subscriptions.append(model)
            }
        }
        return subscriptions
    }
    
    func getSubscriptionsCount() -> Int {
        var subscriptions = [Subscription]()
        
        let query = "SELECT * FROM subscription;"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = String(sqlite3_column_int(statement, 0))
                let subscriptionTitle = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                let subscriptionType = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                let subscriptionAmount = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                let subscriptionStartDate = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                let model = Subscription()
                model.id = id
                model.subscriptionTitle = subscriptionTitle
                model.subscriptionType = subscriptionType
                model.subscriptionAmount = subscriptionAmount
                model.subscriptionStartDate = subscriptionStartDate
                
                subscriptions.append(model)
            }
        }
        return subscriptions.count
    }
    
    func updateSubscription(id: String, subscriptionTitle : String, subscriptionType: String, subscriptionAmount: String, subscriptionStartDate: String) {
        
        let query = "UPDATE subscription SET subscriptionTitle = '\(subscriptionTitle)', subscriptionType = '\(subscriptionType)', subscriptionType = '\(subscriptionType)', subscriptionAmount = '\(subscriptionAmount)', subscriptionStartDate = '\(subscriptionStartDate)' WHERE id = \(id);"        
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Subscription Data updated successfully")
            }else {
                print("Subscription Data is not updated in table")
            }
        }
    }
    
    func deleteSubscription(id : String) {
        let query = "DELETE FROM subscription where id = \(id)"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Subscription Data delete success")
            }else {
                print("Subscription Data is not deleted in table")
            }
        }
    }
    
}
