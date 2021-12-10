//
//  Helper.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

let DEVICE_ID_KEY = "deviceID"
let DEVICE_TYPE = "iOS"

let apiHeaders = [
    "x-rapidapi-host": "ott-details.p.rapidapi.com",
    "x-rapidapi-key": "52ade344f5mshe1ac642310998c2p110980jsnbe2961739535"
]

/**
 Global function to check if the input object is initialized or not.
 
 - parameter value: value to verify for initialization
 
 - returns: true if initialized
 */
public func isObjectInitialized(_ value: AnyObject?) -> Bool {
    guard let _ = value else {
        return false
    }
    return true
}

// MARK: Directory Path helper methods

public func documentsDirectoryPath() -> String? {
    return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
}

public let documentsDirectoryURL: URL = {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.endIndex - 1]
}()

public let cacheDirectoryURL: URL = {
    let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
    return urls[urls.endIndex - 1]
}()

public func deviceInfo() -> [String: String] {
    
    var deviceInfo = [String: String]()
    
    return deviceInfo
}

/**
 Add additional parameters to an existing dictionary
 
 - parameter params: parameters dictionary
 
 - returns: returns final dictionary
 */
func addAdditionalParameters(_ params: [String: AnyObject]) -> [String: AnyObject] {
    
    var finalParams = params
    finalParams["deviceInfo"] = deviceInfo() as AnyObject?
    return finalParams
}

// MARK: Application info methods
/**
 Get version of application.
 
 - returns: Version of app
 */
func applicationVersion() -> String {
    let info: NSDictionary = Bundle.main.infoDictionary! as NSDictionary
    return info.object(forKey: "CFBundleVersion") as! String
}

/**
 Get bundle identifier of application.
 
 - returns: NSBundle identifier of app
 */
func applicationBundleIdentifier() -> NSString {
    return Bundle.main.bundleIdentifier! as NSString
}

/**
 Get name of application.
 
 - returns: Name of app
 */
func applicationName() -> String {
    return Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
}

/**
 Detect that the app is running on a jailbroken device or not
 
 - returns: bool value for jailbroken device or not
 */
func isDeviceJailbroken() -> Bool {
    #if arch(i386) || arch(x86_64)
        //debugPrint("Simulator")
        return false
    #else
        let fileManager = FileManager.default
        
        if (fileManager.fileExists(atPath: "/bin/bash") ||
            fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
            fileManager.fileExists(atPath: "/etc/apt")) ||
            fileManager.fileExists(atPath: "/private/var/lib/apt/") ||
            fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") {
            //debugPrint("Jailbroken Device")
            return true
        } else {
            //debugPrint("Clean Device")
            return false
        }
    #endif
}


func openGoogleMapWith(location: CLLocation) {
    let alert = UIAlertController(title: kGoogleMap, message: kWantToOpenGoogleMap, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: kOpenMap, style: .default, handler: { (_) in
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
        {
            UIApplication.shared.open(URL(string: "comgooglemaps://?saddr=&daddr=\(location.coordinate.latitude),\(location.coordinate.longitude)&directionsmode=driving")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string: "https://maps.google.com/?q=@\(location.coordinate.latitude),\(location.coordinate.longitude)")!, options: [:], completionHandler: nil)
        }
    }))
    
    alert.addAction(UIAlertAction(title: kCancel, style: .cancel, handler: { (_) in
        
    }))
    
    appDel.window?.rootViewController?.present(alert, animated: true, completion: nil)
    
}

func openGoogleMapWith(address: String) {
    
    let addressTrimmed = address.trimmedString().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

    let alert = UIAlertController(title: kGoogleMap, message: kWantToOpenGoogleMap, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: kOpenMap, style: .default, handler: { (_) in
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
        {
            UIApplication.shared.open(URL(string: "comgooglemaps://?saddr=&daddr=\(addressTrimmed!)&directionsmode=driving")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string: "https://maps.google.com/?q=@\(address)")!, options: [:], completionHandler: nil)
        }
    }))
    
    alert.addAction(UIAlertAction(title: kCancel, style: .cancel, handler: { (_) in
        
    }))
    
    appDel.window?.rootViewController?.present(alert, animated: true, completion: nil)
    
}

func callNumber(phoneNumber: String) {
    if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

func sendEmail(emailAddress: String) {
    if let url = URL(string: "mailto:\(emailAddress)") {
        UIApplication.shared.open(url)
    }
}

func openURL(urlString: String) {
    let validUrlString = (urlString.contains("http") || urlString.contains("https")) ? urlString : "http://\(urlString)"
    if let url = URL(string: validUrlString) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_10 = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 812.0
let IS_IPHONE_XR = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 896.0

let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone

func isiPhoneX() -> Bool {
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            debugPrint("iPhone 5 or 5S or 5C")
            return false
        case 1334:
            debugPrint("iPhone 6/6S/7/8")
            return false
        case 2208:
            debugPrint("iPhone 6+/6S+/7+/8+")
            return false
        case 2436:
            debugPrint("iPhone X")
            return true
        default:
            debugPrint("unknown")
            return false
        }
    }
    return false
}

func isStringNullOrEmpty(optionalString: String?) -> Bool {
    if let string = optionalString {
        return string.isEmpty
    } else {
        return true
    }
}

func isNumberNullOrZero(optionalNumber: NSNumber?) -> Bool {
    if let number = optionalNumber {
        if number == NSNumber(value: 0.0) {
            return true
        } else {
            return false
        }
    } else {
        return true
    }
}

func serverDefaultDateTimeFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter
}

func serverDefaultDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter
}

func serverDateFormatterWithSingleHourFormat() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy 'at' h:mm a"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter
}

func appDateFormatterWithSingleHourFormat() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy 'at' h:mm a"
    formatter.timeZone = TimeZone.current
    return formatter
}

func serverDefaultDateTimeFormatterLocal() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.timeZone = TimeZone.current
    return formatter
}

func serverDefaultDateFormatterLocal() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = TimeZone.current
    return formatter
}

func appDateFormatterUTC() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter
}

func appDateTimeFormatterUTC() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy, E, hh:mm a"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter
}

func appDateFormatterLocal() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM dd, yyyy"
    formatter.timeZone = TimeZone.current
    return formatter
}

func appDateTimeFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy 'at' hh:mm a"
    formatter.timeZone = TimeZone.current
    return formatter
}

func appDateTimeFormatterLocal() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy, E, hh:mm a"
    formatter.timeZone = TimeZone.current
    return formatter
}

func appWeekDayFormatterLocal() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE"
    formatter.timeZone = TimeZone.current
    return formatter
}

func appDateNumberFormatterLocal() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    formatter.timeZone = TimeZone.current
    return formatter
}

func appMonthFormatterLocal() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM"
    formatter.timeZone = TimeZone.current
    return formatter
}

func scheduleTimeFormatterLocal() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm a"
    formatter.timeZone = TimeZone.current
    return formatter
}

func scheduleServerTimeFormatterLocal() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    formatter.timeZone = TimeZone.current
    return formatter
}

func scheduleServerTimeFormatterUTC() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter
}

func offlineServerTimeFormatterLocal() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM dd, yyyy, hh:mm a"
    formatter.timeZone = TimeZone.current
    return formatter
}

func filePath(key:String) -> String {
    let manager = FileManager.default
    let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
    return (url!.appendingPathComponent(key).path)
}

func deleteFile(path: String) {
    let exists = FileManager.default.fileExists(atPath: path)
    if exists {
        do {
            try FileManager.default.removeItem(atPath: path)
        }catch let error as NSError {
            debugPrint("error: \(error.localizedDescription)")
        }
    }
}

func isExpiryDateValid(month: Int, year: Int) -> Bool {
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: Date.init(timeIntervalSinceNow: 0))
    let currentMonth = calendar.component(.month, from: Date.init(timeIntervalSinceNow: 0))
    
    if year < currentYear {
        return false
    } else if year == currentYear && month < currentMonth {
        return false
    }
    
    return true
}

// Given a value to round and a factor to round to,
// round the value to the nearest multiple of that factor.
func round(_ value: Double, toNearest: Double) -> Double {
    return round(value / toNearest) * toNearest
}

// Given a value to round and a factor to round to,
// round the value DOWN to the largest previous multiple
// of that factor.
func roundDown(_ value: Double, toNearest: Double) -> Double {
    return floor(value / toNearest) * toNearest
}

// Given a value to round and a factor to round to,
// round the value DOWN to the largest previous multiple
// of that factor.
func roundUp(_ value: Double, toNearest: Double) -> Double {
    return ceil(value / toNearest) * toNearest
}

enum WeekDay: String {
    case monday = "monday"
    case tuesday = "tuesday"
    case wednesday = "wednesday"
    case thursday = "thursday"
    case friday = "friday"
    case saturday = "saturday"
    case sunday = "sunday"
}

func weekDayNumber(weekDay: WeekDay) -> Int {
    if weekDay == .monday {
        return 0
    } else if weekDay == .tuesday {
        return 1
    } else if weekDay == .wednesday {
        return 2
    } else if weekDay == .thursday {
        return 3
    } else if weekDay == .friday {
        return 4
    } else if weekDay == .saturday {
        return 5
    } else if weekDay == .sunday {
        return 6
    }
    return 0
}

func currentTimeZone() -> String {
    return TimeZone.current.identifier
}

func combineDateWithTime(date: Date, time: Date) -> Date? {
    let calendar = NSCalendar.current
    
    let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)

    var mergedComponments = DateComponents()
    mergedComponments.year = dateComponents.year!
    mergedComponments.month = dateComponents.month!
    mergedComponments.day = dateComponents.day!
    mergedComponments.hour = timeComponents.hour!
    mergedComponments.minute = timeComponents.minute!
    mergedComponments.second = timeComponents.second!
    
    return calendar.date(from: mergedComponments)
}

func showAlert(title: String?, message: String?) {
    let actionSheet = UIAlertController(title: "\(title ?? "Sample Response")", message: message ?? "Message not available.", preferredStyle: .alert)
    
    actionSheet.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (_) in
        
    }))
    
    appDel.window?.rootViewController?.present(actionSheet, animated: true, completion: nil)
}

func randomAlphaNumericString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

extension UIStoryboard {
    
    class func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
