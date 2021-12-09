//
//  NSDate+Formatters.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import Foundation

public extension Date {

    static func dateFormatMMMDDYYYY_AT_HHMMA() -> String {
        return "MMM dd, yyyy 'at' hh:mm a"
    }
    
    static func dateFormatCCCCDDMMMYYYY() -> String {
        return "cccc, dd MMM yyyy"
    }
    static func dateFormatCCCCDDMMMMYYYY() -> String {
        return "cccc, dd MMMM yyyy"
    }
    static func dateFormatDDMMMYYYY() -> String {
        return "dd MMM yyyy"
    }
    static func dateFormatDDMMYYYYDashed() -> String {
        return "dd-MM-yyyy"
    }
    static func dateFormatDDMMYYYYSlashed() -> String {
        return "dd/MM/yyyy"
    }
    static func dateFormatDDMMMYYYYSlashed() -> String {
        return "dd/MMM/yyyy"
    }
    static func dateFormatMMMDDYYYY() -> String {
        return "MMM dd, yyyy"
    }
    static func dateFormatYYYYMMDDDashed() -> String {
        return "yyyy-MM-dd"
    }

    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.dateFormatDDMMYYYYDashed()
        return formatter.string(from: self)
    }

    func formattedStringForNotification() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.dateFormatMMMDDYYYY_AT_HHMMA()
        return formatter.string(from: self)
    }
    
    func formattedStringUsingFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
}
