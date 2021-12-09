//
//  HomeVC+TableView.swift
//  SubscriptBea
//
//  Created by Harshit on 27/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSubscriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier()) as! HomeTableViewCell
        cell.configureCell(subscriptionData: self.arrSubscriptions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = DetailVC.instantiate()
        obj.subscriptionData = self.arrSubscriptions[indexPath.row]
        obj.isNew = false
        self.push(vc: obj)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            let obj = DetailVC.instantiate()
            obj.subscriptionData = self.arrSubscriptions[indexPath.row]
            obj.isNew = false
            self.push(vc: obj)
        })
        editAction.backgroundColor = UIColor.blue

        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.showDeleteConfirmation(id: self.arrSubscriptions[indexPath.row].id)
            
        })
        deleteAction.backgroundColor = UIColor.red

        return [editAction, deleteAction]
    }
    
    func showDeleteConfirmation(id: String?) {
        
        let alert = UIAlertController(title: "Delete", message: kAreYouSureToDeleteSubscription, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (_) in
            self.deleteSubscription(id: id)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteSubscription(id: String?) {
        if let id = id, let userId = self.user.id {
            self.ref.child("users").child(userId).child("subscriptions").child(id).removeValue()
            
        }
        HMMessage.showSuccessWithMessage(message: "Deleted successfully")
        self.getSubscriptions()
    }
}
