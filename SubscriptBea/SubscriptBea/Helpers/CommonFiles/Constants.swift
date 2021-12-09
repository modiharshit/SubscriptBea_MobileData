//
//  Constants.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import Foundation
import UIKit

let appDel = UIApplication.shared.delegate as! AppDelegate
let sceneDel = UIApplication.shared.delegate as! SceneDelegate

enum DeviceType: String {
    case iOS = "iPhone"
    case Android = "Android"
}

struct Constants {
    
    struct TextLength {
        static let GenericMaxTextLength = 256
        static let VerificationCodeLength = 4
        static let PriceBeforeDecimalLength = 6
        static let PriceAfterDecimalLength = 2
        static let RulesShort = 100
        static let PasswordMaxLength = 30
        static let PhoneNumberMaxLength = 15
        static let NoLimit = Int(INT_MAX)
        static let ShortDescriptionTextLength = 200
        static let ZipCodeMaxLength = 10
        static let ZipCodeMinLength = 6
        static let PriceMaxLength = 7
        static let QuantityMaxLength = 3
        static let AccountNumberMaxLength = 17
        static let RoutingNumberMaxLength = 9
    }
    
    struct AcceptableCharacters {
        static let OnlyNumbers = "0123456789"
        static let Price = "0123456789."
        static let PhoneNumber = "+0123456789"
        static let Alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        static let AlphabetsWithSpace = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
        static let AlphabetsNumbersWithSpace = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
        static let AlphabetsNumbersDashOnly = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-"
        static let NumbersWithSpace = "0123456789 "
    }
    
    struct CharacterSets {
        static let SpaceCharacterSetInverted = CharacterSet(charactersIn: " ").inverted
    }
    
    struct Default {
        static let animationDuration: TimeInterval = 0.3
        static let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        static let font: UIFont = UIFont.systemFont(ofSize: 14)
        static let itemSpacing: CGFloat = 6
        static let rowSpacing: CGFloat = 6
        static let textFieldCellMinWidth: CGFloat = 60
        static let labelTextColor: UIColor = .darkText
        static let textFieldTextColor: UIColor = .darkText
        static let defaultTokenTopBottomPadding: CGFloat = 4
        static let defaultTokenLeftRightPadding: CGFloat = 8
    }
    
    struct Identifier {
        static let labelCell: String = "ResizingTokenFieldLabelCell"
        static let tokenCell: String = "ResizingTokenFieldTokenCell"
        static let textFieldCell: String = "ResizingTokenFieldTextFieldCell"
    }
    
    struct ScreenSize {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    }
    
    struct AppInfo {
        static let appID = "1"
        static let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        static let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
    
    struct color {
        static let kAPP_COLOR = Constants.color.kApp_Blue_Color
        
        static let kApp_Blue_Color = UIColor(red: 42.0/255.0, green: 172.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        
        static let kTEXTFIELD_PLACEHOLDER_COLOR = UIColor(red: 186.0/255.0, green: 187.0/255.0, blue: 188.0/255.0, alpha: 1.0)
        
        static let kTextFieldBorderColor = UIColor(red: 231.0/255.0, green: 231.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        
    }
    
    struct UserDefaultKeys {
        static let ACTIVE_USER_KEY = "activeUser"
        static let DeviceTokenKey = "DeviceTokenKey"
        static let UserNameKey = "UserNameKey"
        static let UserEmailKey = "UserEmailKey"
        static let DeepLinkParams = "DeepLinkParams"
    }
    
    static let kKeyboardDistanceFromTextField: CGFloat = 20.0
 
    static let googleClientId = "75832076040-3h9occi19llgbuu2air0iialqu50up44.apps.googleusercontent.com"
    
    static let reversedGoogleClientId = "75832076040-3h9occi19llgbuu2air0iialqu50up44.apps.googleusercontent.com"
}
