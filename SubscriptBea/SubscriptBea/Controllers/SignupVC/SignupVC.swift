//
//  SignupVC.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: HMBaseVC {

    //MARK:- Outlets
    @IBOutlet weak var txtFirstName: HMTextField!
    @IBOutlet weak var txtLastName: HMTextField!
    @IBOutlet weak var txtEmail: HMTextField!
    @IBOutlet weak var txtPassword: HMTextField!
    @IBOutlet weak var txtConfirmPassword: HMTextField!
    
    @IBOutlet weak var btnSignup: HMButton!
    
    //MARK:- Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func instantiate() -> SignupVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: SignupVC.identifier()) as! SignupVC
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVC()
    }
    
    
    @IBAction func btnSignupAction(_ sender: Any) {
        self.createUser { (success) in
            if success {
                
                //SET HOME AS ROOT CONTROLLER
                self.popVC()
            } else {
                HMMessage.showErrorWithMessage(message: "Failed to signup.")
            }
        }
    }
}

extension SignupVC {
    
    func createUser(completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                self.ref.child("users").child(user.uid).setValue([
                    "id": user.uid,
                    "firstName" : self.txtFirstName.text!,
                    "lastName" : self.txtLastName.text!,
                    "email" : self.txtEmail.text!
                ])
                
                let user = User(id: user.uid, firstName: self.txtFirstName.text!, lastName: self.txtLastName.text!, email: self.txtEmail.text!, profilePicture: "")
                UserManager.sharedManager().activeUser = user
                
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
}
