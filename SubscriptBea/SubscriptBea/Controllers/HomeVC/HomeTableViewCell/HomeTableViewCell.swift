//
//  HomeTableViewCell.swift
//  SubscriptBea
//
//  Created by Harshit on 27/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var vwBG: HMView!
    @IBOutlet weak var vwImage: HMView!
    @IBOutlet weak var imgTitle: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDueDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
    func configureCell(subscriptionData: Subscription) {
        self.lblTitle.text = subscriptionData.subscriptionTitle
        
        if let amountString = subscriptionData.subscriptionAmount {
            let number = NumberFormatter().number(from: amountString)
            self.lblAmount.text = number?.commaFormattedAmountStringSingleFraction(showSymbol: true)
        }
        
        self.lblDueDate.text = subscriptionData.subscriptionType
        self.imgTitle.image = imageWith(name: subscriptionData.subscriptionTitle)
    }
    
    func imageWith(name: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: vwImage.frame.width, height: vwImage.frame.height)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .random()
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 32)
        var initials = ""
        if let initialsArray = name?.components(separatedBy: " ") {
            if let firstWord = initialsArray.first {
                if let firstLetter = firstWord.first {
                    initials += String(firstLetter).capitalized }
            }
            if initialsArray.count > 1, let lastWord = initialsArray.last {
                if let lastLetter = lastWord.first { initials += String(lastLetter).capitalized
                }
            }
        } else {
            return nil
        }
        nameLabel.text = initials
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
