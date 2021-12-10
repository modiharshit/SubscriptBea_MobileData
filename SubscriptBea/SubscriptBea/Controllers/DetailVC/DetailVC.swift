//
//  DetailVC.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import IQDropDownTextField

class DetailVC: HMBaseVC {
    
    var type = ["Weekly","Bi-weekly","Monthly","Quaterly","Half-yearly","Annual"]
    
    var user = User()
    var subscriptionData = Subscription()
    var isNew : Bool = false
    var datePicker = UIDatePicker()
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtTitle: HMTextField!
    @IBOutlet weak var txtSubscriptionType: IQDropDownTextField!
    @IBOutlet weak var txtStartDate: IQDropDownTextField!
    @IBOutlet weak var txtAmount: HMTextField!
    
    @IBOutlet weak var btnSave: HMButton!
    @IBOutlet weak var btnDeleteSubscription: HMButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTextField()
        self.initializeTypeTextField()
        
        if self.isNew {
            self.lblTitle.text = "Add Subscription"
            self.btnDeleteSubscription.isHidden = true
            self.btnSave.setTitle("Save", for: .normal)
        } else {
            self.lblTitle.text = "Update Subscription"
            self.btnDeleteSubscription.isHidden = false
            self.btnSave.setTitle("Update", for: .normal)
            self.loadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.user = UserManager.sharedManager().activeUser
    }
    
    class func instantiate() -> DetailVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: DetailVC.identifier()) as! DetailVC
    }
    
    func loadData() {
        self.txtTitle.text = self.subscriptionData.subscriptionTitle
        self.txtSubscriptionType.selectedItem = self.subscriptionData.subscriptionType
        
        if let strDate = self.subscriptionData.subscriptionStartDate {
            
            self.txtStartDate.date = getDate(strDate: strDate)
        }
        
        if let amountString = self.subscriptionData.subscriptionAmount {
            let number = NumberFormatter().number(from: amountString)
            self.txtAmount.text = number?.commaFormattedAmountStringSingleFraction(showSymbol: false)
        }
    }
    
    func getDate(strDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        print(dateFormatter.date(from: strDate))
        return dateFormatter.date(from: strDate) // replace Date String
    }
    
    func initializeTextField() {
        
        self.txtStartDate.dropDownMode = .datePicker
        self.txtStartDate.placeholder = "Select Subscription Start Date"
        
        self.txtStartDate.datePicker.minimumDate = Date().dateBeforeDays(days: 730) //MINIMUM 2 Years
        self.txtStartDate.datePicker.maximumDate = Date().dateAfterDays(days: 730) //MAXIMUM 2 Years
        self.txtStartDate.dateTimeFormatter = appDateFormatterWithSingleHourFormat()
        
        self.txtStartDate.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(self.doneAction(_:)))
        
        self.txtStartDate.delegate = self
    }
    
    func initializeTypeTextField() {
        self.txtSubscriptionType.isOptionalDropDown = false
        self.txtSubscriptionType.itemList = self.type
    }
    
    func showDeleteConfirmation() {
        
        let alert = UIAlertController(title: "Delete", message: kAreYouSureToDeleteSubscription, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (_) in
            self.deleteSubscription()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVC()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        if self.isNew {
            self.saveSubscription()
        } else {
            self.updateSubscription()
        }        
        HMMessage.showSuccessWithMessage(message: self.isNew ? "Subscription Added successfully" : "Updated Successfully")
        self.popVC()
    }
    
    @IBAction func btnDeleteSubscriptionAction(_ sender: Any) {
        self.showDeleteConfirmation()
    }
    
}

extension DetailVC {
    
    func saveSubscription() {
        self.sqliteDB.insertSubscription(subscriptionTitle: self.txtTitle.text!,
                                         subscriptionType: self.txtSubscriptionType.selectedItem! as String,
                                         subscriptionAmount: self.txtAmount.text!,
                                         subscriptionStartDate: self.txtStartDate.date?.getFullDateInDefaultFormat() ?? Date().getFullDateInDefaultFormat())
    }
    
    func deleteSubscription() {
        if let id = self.subscriptionData.id {
            self.sqliteDB.deleteSubscription(id: id)
        }
        HMMessage.showSuccessWithMessage(message: "Deleted successfully")
        self.popVC()
    }
    
    func updateSubscription() {
        if let userId = self.user.id, let id = self.subscriptionData.id {
            self.sqliteDB.updateSubscription(id: id,
                                             subscriptionTitle: self.txtTitle.text!,
                                             subscriptionType: self.txtSubscriptionType.selectedItem! as String,
                                             subscriptionAmount: self.txtAmount.text!,
                                             subscriptionStartDate: self.txtStartDate.date?.getFullDateInDefaultFormat() ?? Date().getFullDateInDefaultFormat())
        }
        HMMessage.showSuccessWithMessage(message: "Profile updated successfully.")
    }
}

extension DetailVC: IQDropDownTextFieldDelegate {
    
    // MARK: - IQDropDownTextFieldDelegate
    
    @objc func doneAction(_ sender : IQDropDownTextField) {
        self.txtStartDate.date = sender.datePicker.date
    }
}
