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
    
    
    
    //MARK:- CLASS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.user = UserManager.sharedManager().activeUser
        self.getSubscriptions()
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
        self.arrSubscriptions = (self.sqliteDB.getSubscription())!
        self.tableView.reloadData()        
    }
}
