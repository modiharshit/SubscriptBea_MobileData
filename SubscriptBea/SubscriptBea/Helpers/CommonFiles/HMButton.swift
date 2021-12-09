//
//  HMButton.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class HMButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBInspectable var circular: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    @IBInspectable var circularUsingHeight: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var spacingBetweenImageAndTitle: CGFloat = 0.0 {
        didSet {
            let insetAmount = spacingBetweenImageAndTitle / 2
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var radius: CGFloat = 0.0
        if cornerRadius != 0 {
            radius = cornerRadius
        } else if circular {
            radius = self.bounds.size.width / 2.0
        } else if circularUsingHeight {
            radius = self.bounds.size.height / 2.0
            self.layer.masksToBounds = true
        }
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
