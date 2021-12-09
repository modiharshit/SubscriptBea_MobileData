//
//  Date+Additions.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit

extension Date {
    
    func dateAfterSeconds(seconds: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .second, value: seconds, to: self)!
    }
    
    func dateAfterMinutes(minutes: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func dateAfterHours(hours: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: hours, to: self)!
    }
    
    func dateAfterDays(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func dateAfterYears(years: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: years, to: self)!
    }
    
    func dateBeforeDays(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -days, to: self)!
    }
    
    func isGreaterThan(date: Date) -> Bool {
        return self > date
    }
    
    func isEqualTo(date: Date) -> Bool {
        return self == date
    }
    
    func isLessThan(date: Date) -> Bool {
        return self < date
    }
    
    func isToday() -> Bool {
        return NSCalendar.current.isDateInToday(self)
    }
    
    func isYesterday() -> Bool {
        return NSCalendar.current.isDateInYesterday(self)
    }
    
    func isTomorrow() -> Bool {
        return NSCalendar.current.isDateInTomorrow(self)
    }
    
    static func getCurrentDateTimeInAppFormat() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        return result
    }
    
    static func getCurrentDateTimeInDefaultFormat() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
        let result = formatter.string(from: date)
        return result
    }
    
    static func getCurrentDateTimeInServerFormat() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: date)
    }
    
    func getEventDateTimeInDefaultFormat() -> String {
        let now = Date()
        let earliest = now < self ? now : self
        let latest = (earliest == now) ? self : now
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .weekOfYear], from: earliest,  to: latest)
        
        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        } else if let year =  components.year, year >= 1 {
            return "1 year ago"
        } else if let month = components.month, month >= 2 {
            return "\(month) months ago"
        } else if let month = components.month, month >= 1 {
            return "1 month ago"
        } else if let weekOfYear = components.weekOfYear, weekOfYear >= 2 {
            return "\(weekOfYear) weeks ago"
        } else if let weekOfYear = components.weekOfYear, weekOfYear >= 1 {
            return "1 week ago"
        } else if let day = components.day, day >= 2 {
            return "\(day) days ago"
        } else if let day = components.day, day >= 1 {
            return "1 day ago"
        } else if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        } else if let hour = components.hour, hour >= 1 {
            return "1 hour ago"
        } else if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        } else if let minute = components.minute, minute >= 1 {
            return "1 minute ago"
        } else if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        } else {
            return "Just now"
        }
    }
    
    func getCommentDateTimeInDefaultFormat() -> String {
        let now = Date()
        let earliest = now < self ? now : self
        let latest = (earliest == now) ? self : now
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .weekOfYear], from: earliest,  to: latest)
        
        if let year = components.year, year >= 2 {
            return "\(year) years"
        } else if let year =  components.year, year >= 1 {
            return "1 year"
        } else if let month = components.month, month >= 2 {
            return "\(month) months"
        } else if let month = components.month, month >= 1 {
            return "1 month"
        } else if let weekOfYear = components.weekOfYear, weekOfYear >= 2 {
            return "\(weekOfYear) weeks"
        } else if let weekOfYear = components.weekOfYear, weekOfYear >= 1 {
            return "1 week"
        } else if let day = components.day, day >= 2 {
            return "\(day) days"
        } else if let day = components.day, day >= 1 {
            return "1 day"
        } else if let hour = components.hour, hour >= 2 {
            return "\(hour) hours"
        } else if let hour = components.hour, hour >= 1 {
            return "1 hour"
        } else if let minute = components.minute, minute >= 2 {
            return "\(minute) mins"
        } else if let minute = components.minute, minute >= 1 {
            return "1 min"
        } else if let second = components.second, second >= 3 {
            return "\(second) sec"
        } else {
            return "Just now"
        }
    }
    
    func getDateInDefaultFormat() -> String {
        if self.isToday() {
            return "Today"
        } else if self.isYesterday() {
            return "Yesterday"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    func getDateTimeInDefaultFormatWithSingleDigitHour() -> String {
        // From Server: 2017-09-15 06:20:47
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy 'at' h:mm a"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    
    func getDateInDefaultFormatForServer() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    func getFullDateInDefaultFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }

    func gmtString() -> String {
        return serverDefaultDateTimeFormatter().string(from: self)
    }
    
    static func getDates(forNextNDays nDays: Int) -> [Date] {
        let cal = NSCalendar.current
        
        // start with today
        var date = cal.startOfDay(for: Date())

        var arrDates = [Date]()

        arrDates.append(date)
        
        for _ in 1 ... nDays {
            // move back in time by one day:
            date = cal.date(byAdding: Calendar.Component.day, value: 1, to: date)!
            arrDates.append(date)
        }
        print(arrDates)
        return arrDates
    }
}
