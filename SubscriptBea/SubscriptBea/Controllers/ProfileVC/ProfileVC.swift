//
//  ProfileVC.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices
import Firebase
import FirebaseStorage
import SDWebImage
import ObjectMapper

class ProfileVC: HMBaseVC {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnProfileImage: UIButton!
    
    @IBOutlet weak var txtFirstName: HMTextField!
    @IBOutlet weak var txtLastName: HMTextField!
    @IBOutlet weak var txtEmail: HMTextField!
    
    @IBOutlet weak var lblTotalSubscriptions: UILabel!
    
    @IBOutlet weak var btnUpdateProfile: HMButton!
    @IBOutlet weak var btnLogout: HMButton!
    
    var profileImage: UIImage?
    var imagePicker = UIImagePickerController()
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    class func instantiate() -> ProfileVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: ProfileVC.identifier()) as! ProfileVC
    }
    
    func loadData() {
        self.user = UserManager.sharedManager().activeUser
        
        self.getUserProfile()
        self.getSubscriptions()
    }
    
    func showLogoutConfirmation() {
        
        let alert = UIAlertController(title: "Logout", message: kAreYouSureToLogout, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (_) in
            UserManager.sharedManager().logout()
            let obj = LoginVC.instantiate()
            self.push(vc: obj)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVC()
    }
    
    @IBAction func btnProfileImageAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Upload Photo", message: "Select an option", preferredStyle: .actionSheet)
                
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            self.selectImage(sourceType: .camera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (_) in
            self.selectImage(sourceType: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func btnUpdateProfileAction(_ sender: Any) {
        if self.profileImage == nil {
            self.updateUser()
        } else {
            self.uploadMedia()
        }
    }
    
    @IBAction func btnLogoutAction(_ sender: Any) {
        self.showLogoutConfirmation()
    }
}

extension ProfileVC :  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UIImagePickerControllerDelegate
    
    func selectImage(sourceType: UIImagePickerController.SourceType) {
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.modalPresentationStyle = .fullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.profileImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        self.imgProfile.image = profileImage
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC {
    
    func getSubscriptions() {
        self.lblTotalSubscriptions.text = "\(self.sqliteDB.getSubscriptionsCount())"
    }
    
    func getUserProfile() {
        if let userID = self.user.id {
            self.ref.child("users").child(userID).observeSingleEvent(of: .value, with: { snapshot in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let userId = value?["id"] as? String ?? ""
                let firstName = value?["firstName"] as? String ?? ""
                let lastName = value?["lastName"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                let profileImageUrl =  value?["profilePicture"] as? String ?? ""
                
                let user = User(id: userId, firstName: firstName, lastName: lastName, email: email, profilePicture: profileImageUrl)
                UserManager.sharedManager().activeUser = user
                
                self.txtFirstName.text = firstName
                self.txtLastName.text = lastName
                self.txtEmail.text = email
                self.imgProfile.sd_setImage(with: URL(string: profileImageUrl ), placeholderImage: UIImage(named: "ic_logo.png"))
                
                print(profileImageUrl)
            })
        }
    }
    
    func updateUser() {
        if let userId = self.user.id, userId.count > 0 {
            self.ref.child("users").child(userId).updateChildValues([
                "firstName" : self.txtFirstName.text!,
                "lastName" : self.txtLastName.text!,
            ])
            let user = User(id: self.user.id, firstName: self.txtFirstName.text, lastName: self.txtLastName.text, email: self.user.email, profilePicture: "")
            UserManager.sharedManager().activeUser = user
            
            HMMessage.showSuccessWithMessage(message: "Profile updated successfully.")
        }
    }
    
    func updateUserProfileImage(imageUrl: String?) {
        if let userId = self.user.id, userId.count > 0 {
            self.ref.child("users").child(userId).updateChildValues([
                "firstName" : self.txtFirstName.text!,
                "lastName" : self.txtLastName.text!,
                "profilePicture" : imageUrl
            ])
            let user = User(id: self.user.id, firstName: self.txtFirstName.text, lastName: self.txtLastName.text, email: self.user.email, profilePicture: imageUrl)
            UserManager.sharedManager().activeUser = user
            
            HMMessage.showSuccessWithMessage(message: "Profile updated successfully.")
        }
    }
    
    func uploadMedia() {
        if let userId = self.user.id {
            let storageRef = Storage.storage().reference().child("\(userId)\(self.timestamp).png")
            if let img = self.profileImage {
                if let imageData = img.jpeg(.lowest) {
                    storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            print("error")
                            return}
                        else{
                            storageRef.downloadURL(completion: { (url, error) in
                                print("Image URL: \((url?.absoluteString)!)")
                                self.updateUserProfileImage(imageUrl: (url?.absoluteString)!)
                            })
                        }
                    })
                }

            }
        }
    }
}
