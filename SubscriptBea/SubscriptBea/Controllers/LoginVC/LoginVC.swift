//
//  LoginVC.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: HMBaseVC {

    //MARK:- OUTLETS
    @IBOutlet weak var txtEmail: HMTextField!
    @IBOutlet weak var txtPassword: HMTextField!
    
    @IBOutlet weak var btnLogin: HMButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    //MARK:- CLASS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    class func instantiate() -> LoginVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: LoginVC.identifier()) as! LoginVC
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        self.signIn { (success) in
            if success {
                
                //SET ROOT CONTROLLER
                let obj = HomeVC.instantiate()
                self.push(vc: obj)
                
            } else {
                self.showAlertWithMessage(message: "Failed to Login.")
            }
        }
    }
    
    @IBAction func btnSignupAction(_ sender: Any) {
        let obj = SignupVC.instantiate()
        self.push(vc: obj)
    }
    
}

extension LoginVC {
    
    func validateTextFields() {
        
    }
    
    func signIn( completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                
                guard let userID = Auth.auth().currentUser?.uid else { return }
                print(userID)
                
                self.ref.child("users").child(userID).observeSingleEvent(of: .value, with: { snapshot in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    let userId = value?["id"] as? String ?? ""
                    let firstName = value?["firstName"] as? String ?? ""
                    let lastName = value?["lastName"] as? String ?? ""
                    let email = value?["email"] as? String ?? ""
                    
                    
                    let user = User(id: userId, firstName: firstName, lastName: lastName, email: email, profilePicture: "")
                    UserManager.sharedManager().activeUser = user
                
                    completionBlock(true)
                }) { error in
                    print(error.localizedDescription)
                    completionBlock(false)
                }
            }
        }
    }
}
