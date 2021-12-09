//
//  HMBaseVC.swift
//  SubscriptBea
//
//  Created by Harshit on 27/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit
import Firebase

class HMBaseVC: UIViewController {
    
    let ref = Database.database().reference()
    let timestamp = NSDate().timeIntervalSince1970
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlertWithMessage(message: String){
        let  alertController = UIAlertController(title: applicationName(), message: message, preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
            }))
        self.present(alertController, animated: true, completion: nil)
    }
}
