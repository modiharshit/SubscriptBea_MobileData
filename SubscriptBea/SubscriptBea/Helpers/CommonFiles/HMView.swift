//
//  HMView.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class HMView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var rightCorners: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var topCorners: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var leftRight: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
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
    
    @IBInspectable var addShadow: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var radius: CGFloat = 0.0
        if cornerRadius != 0 {
            radius = cornerRadius
            self.layer.masksToBounds = true
        } else if circular {
            radius = self.bounds.size.width / 2.0
            self.layer.masksToBounds = true
        } else if circularUsingHeight {
            radius = self.bounds.size.height / 2.0
            self.layer.masksToBounds = true
        } else if leftRight {
            radius = self.bounds.size.height / 2.0
            self.layer.masksToBounds = true
        } else if topCorners {
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.layer.masksToBounds = true
        } else if rightCorners {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            self.layer.masksToBounds = true
        }
        
        self.layer.cornerRadius = radius
        
        if addShadow {
            addShadowUnderView()
        }
    }

    func addShadowUnderView() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}
