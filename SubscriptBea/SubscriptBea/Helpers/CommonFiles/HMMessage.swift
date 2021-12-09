//
//  HMMessage.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit
import SwiftMessages

class HMMessage: NSObject {
    class func showBannerWith(_ title:String?, body: String?, theme: Theme) {
        let view: MessageView
        view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: title, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "", buttonTapHandler: { _ in SwiftMessages.hide() })
        view.titleLabel?.font = FontManager.montserratFont(fontName: .semiBold, size: 17)
        view.bodyLabel?.font = FontManager.montserratFont(fontName: .semiBold, size: 16)
        let iconStyle: IconStyle
        iconStyle = .default
        view.configureTheme(theme, iconStyle: iconStyle)
        view.configureDropShadow()
        view.button?.isHidden = true
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.duration = .seconds(seconds: 3)
        config.interactiveHide = true
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: view)
    }
    
    class func showBannerWith(_ title:String?, body: String?, theme: Theme, duration: Int) {
        let view: MessageView
        view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: title, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "", buttonTapHandler: { _ in SwiftMessages.hide() })
        view.titleLabel?.font = FontManager.montserratFont(fontName: .semiBold, size: 16)
        view.bodyLabel?.font = FontManager.montserratFont(fontName: .semiBold, size: 16)
        let iconStyle: IconStyle
        iconStyle = .default
        view.configureTheme(theme, iconStyle: iconStyle)
        view.configureDropShadow()
        view.button?.isHidden = true
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.duration = .seconds(seconds: TimeInterval(duration))
        config.interactiveHide = true
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: view)
    }
    
    
    class func showSuccessWithMessage(message: String?) {
        HMMessage.showBannerWith(kSuccess, body: message, theme: .success)
    }
    
    class func showWarningWithMessage(message: String?) {
        HMMessage.showBannerWith(kWarning, body: message, theme: .warning)
    }
    
    class func showErrorWithMessage(message: String?) {
        HMMessage.showBannerWith(kError, body: message, theme: .error)
    }
    
    class func showInfoWithMessage(message: String?) {
        HMMessage.showBannerWith(kInfo, body: message, theme: .info)
    }
}
