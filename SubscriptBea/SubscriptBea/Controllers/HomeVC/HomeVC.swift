//
//  HomeVC.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper

class HomeVC: HMBaseVC {

    //MARK:- OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnProfile: UIButton!
    
    @IBOutlet weak var btnPlus: UIButton!
    
    var user = User()
    var arrSubscriptions : [Subscription] = []
    
    let db = DBHelper()
    
    //MARK:- CLASS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
//        self.getMySubscriptions()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.user = UserManager.sharedManager().activeUser
        self.getSubscriptions()
        
//        // create table
        db.createTableSubscription()
//
//        // insert
        db.insertSubscription(id: "", subscriptionTitle: "Hulu", subscriptionType: "Weekly", subscriptionAmount: "1000.0", subscriptionStartDate: "")
//
//        // list
//        var subscriptions: [SubscriptionModel] = db.readSubscription()
//
//        // update
//        db.updateSubscription(id: "1", subscriptionTitle: "Amazon Prime", subscriptionType: "Weekly", subscriptionAmount: "1000.0", subscriptionStartDate: "")
//
//        // delete
//        db.deleteSubscription(id: 2)
        
    }
    
    class func instantiate() -> HomeVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: HomeVC.identifier()) as! HomeVC
    }
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: HomeTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: HomeTableViewCell.reuseIdentifier())
    }
    
    @IBAction func btnProfileAction(_ sender: Any) {
        let objProfileVC = ProfileVC.instantiate()
        self.push(vc: objProfileVC)
    }
    
    @IBAction func btnPlusAction(_ sender: Any) {
        let obj = DetailVC.instantiate()
        obj.isNew = true
        self.push(vc: obj)
    }
}

extension HomeVC {
    
    func getSubscriptions() {
        self.arrSubscriptions.removeAll()
        
        if let userID = self.user.id {
            let placeRef = self.ref.child("users").child(userID).child("subscriptions")
            
            placeRef.observeSingleEvent(of: .value, with: { snapshot in
                
                if snapshot.childrenCount > 0 {
                    for child in snapshot.children {
                        let snap = child as! DataSnapshot
                        let placeDict = snap.value as! [String: Any]
                        
                        if let subscription: Subscription = Mapper<Subscription>().map(JSON: placeDict) {
                            self.arrSubscriptions.append(subscription)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            })
        }
    }
}
