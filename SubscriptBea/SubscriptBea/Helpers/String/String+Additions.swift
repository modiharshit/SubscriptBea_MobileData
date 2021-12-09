//
//  String+Additions.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import Foundation
import UIKit

extension Optional where Wrapped == String {
    
    func safeString() -> String {
        if self == nil {
            return ""
        } else {
            return self!
        }
    }
    
    func safeNAString() -> String {
        if self == nil {
            return "NA"
        } else {
            return self!
        }
    }
    
    func isNullOrEmpty() -> Bool {
        let optionalString: String? = self
        if optionalString == nil || optionalString?.isEmpty == true {
            return true
        }
        return false
    }
}

extension String {
    
    var digits: String {
        let stringArray = components(separatedBy: CharacterSet(charactersIn: Constants.AcceptableCharacters.PhoneNumber).inverted)
        let newString = stringArray.joined(separator: "")
        return newString
    }
    
    func length() -> Int {
        return self.count
    }
    
    func trimmedString() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func onlyNumbers() -> String {
        let stringWithoutDash = self.replacingOccurrences(of: "-", with: "")
        return stringWithoutDash.trimmingCharacters(in: CharacterSet(charactersIn: Constants.AcceptableCharacters.PhoneNumber).inverted)
    }

    // formatting text for currency textField
    func currencyOutputFormatting() -> String {
        
        if let doubleValue = Double(self) {
            let number: NSNumber = NSNumber(value: doubleValue)
            let formatter = NumberFormatter()
            formatter.currencySymbol = "$"
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 0
            formatter.numberStyle = .currency
            if let amount = formatter.string(from: number) {
                return amount
            } else {
                return "$ NA"
            }
        } else {
            return "$ NA"
        }
    }
    
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    func currencyInputFormattingInt() -> String {
        if let amount = Double(self) {
            let formatter = NumberFormatter()
            formatter.currencySymbol = "$"
            formatter.maximumFractionDigits = 0
            formatter.minimumFractionDigits = 0
            formatter.numberStyle = .currency
            if let amount = formatter.string(from: NSNumber(value: amount)) {
                return amount
            } else {
                return ""
            }
        }
        return ""
    }
    
    func priceValueFromString() -> NSNumber? {
        let string = self.replacingOccurrences(of: ",", with: "")
        if let doubleValue = Double(string) {
            return NSNumber(value: doubleValue)
        } else {
            return nil
        }
    }
    
    /**
     Specify that string contains valid email address.
     
     - returns: A Bool return true if string has valid email otherwise false.
     */
    func isValidEmail() -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool {
        
        let phoneNumberFormat = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberFormat)
        return phoneNumberPredicate.evaluate(with: self)
    }
    
    /**
     Specify that string contains valid password.
     
     - returns: A Bool return true if string has valid password otherwise false.
     */
    func isValidPassword() -> Bool {
        
        let passwordRegex = "^[a-zA-Z0-9]{5,15}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let rVal = passwordTest.evaluate(with: self)
        if !rVal {
            
        }
        return rVal
    }
    
    /**
     Specify that string contains valid web url.
     
     - returns: A Bool return true if it is valid url otherwise false.
     */
    func isValidUrl() -> Bool {
        guard let _ = URL(string: self) else {return false}
        
        let regEx = "((https|http)://)?((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: self)
    }
    
    func utf8EncodeString() -> String {
        if let data = self.data(using: String.Encoding.nonLossyASCII) {
            if let value = String(data: data, encoding: String.Encoding.utf8) {
                return value
            }
        }
        return self
    }
    
    func utf8DecodeString() -> String {
        if let data = self.data(using: String.Encoding.utf8) {
            if let value = String(data: data, encoding: String.Encoding.nonLossyASCII) {
                return value
            }
        }
        return self
    }
    
    func size(using font: UIFont, availableWidth: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        
        let size = CGSize(width: availableWidth, height: .greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [ .usesLineFragmentOrigin, .usesFontLeading ]
        let boundingRect = self.boundingRect(with: size, options: options, attributes: [ .font: font ], context: nil)
        let ceilSize = CGSize(width: ceil(boundingRect.width), height: ceil(boundingRect.height))
        
        return ceilSize
    }
    
    func camelCased() -> String {
        return self.replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: self.range(of: self))
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .capitalized
    }
    
    func isValidURL() -> Bool {
        guard let _ = URL(string: self) else {return false}
        
        let regEx = "((https|http)://)?((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: self)
    }
    
    var numberValue: NSNumber? {
        if let value = Int(self) {
            return NSNumber(value: value)
        }
        return nil
    }
}
