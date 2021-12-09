//
//  String+Attributions.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit

extension String {
    
    func attributedString(attributes: [NSAttributedString.Key: Any], substring: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        var rangeOfSubstring: NSRange?
        if self.contains(substring) {
            rangeOfSubstring = (self as NSString).range(of: substring)
        }
        if rangeOfSubstring != nil {
            attributedString.addAttributes(attributes, range: rangeOfSubstring!)
        }
        
        return attributedString
    }
    
    func fullUnderlineString() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let rangeOfSubstring: NSRange? = (self as NSString).range(of: self)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangeOfSubstring!)
        return attributedString
    }
}
