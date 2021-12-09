//
//  NSNumber+Additions.swift
//  SubscriptBea
//
//  Created by Harshit on 08/12/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import Foundation
import UIKit

extension Optional where Wrapped == NSNumber {
    
    func isNullOrEmpty() -> Bool {
        let optionalNumber: NSNumber? = self
        if optionalNumber == nil {
            return true
        } else if optionalNumber!.doubleValue <= 0.0 {
            return true
        }
        return false
    }
}

extension NSNumber {
    
    func commaFormattedAmountString(showSymbol: Bool? = true) -> String {
        let numberFormatter = NumberFormatter()
        if showSymbol! == true {
            numberFormatter.currencySymbol = "$"
        } else {
            numberFormatter.currencySymbol = ""
        }
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        if let formattedNumber = numberFormatter.string(from: self) {
            return formattedNumber
        }
        return "$NA"
    }
    
    func commaFormattedAmountStringNoFraction(showSymbol: Bool? = true) -> String {
        let numberFormatter = NumberFormatter()
        if showSymbol! == true {
            numberFormatter.currencySymbol = "$"
        } else {
            numberFormatter.currencySymbol = ""
        }

        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        if let formattedNumber = numberFormatter.string(from: self) {
            return formattedNumber
        }
        return "$NA"
    }
    
    func commaFormattedAmountStringSingleFraction(showSymbol: Bool? = true) -> String {
        let numberFormatter = NumberFormatter()
        if showSymbol! == true {
            numberFormatter.currencySymbol = "$"
        } else {
            numberFormatter.currencySymbol = ""
        }
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        if let formattedNumber = numberFormatter.string(from: self) {
            return formattedNumber
        }
        return "$NA"
    }
    
    func commaFormattedAmountStringDoubleFraction(showSymbol: Bool? = true) -> String {
        let numberFormatter = NumberFormatter()
        if showSymbol! == true {
            numberFormatter.currencySymbol = "$"
        } else {
            numberFormatter.currencySymbol = ""
        }
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        if let formattedNumber = numberFormatter.string(from: self) {
            return formattedNumber
        }
        return "$NA"
    }
    
    
}
