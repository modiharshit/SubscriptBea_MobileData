//
//  NavigationController.swift
//  SubscriptBea
//
//  Created by Harshit on 28/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {
    
    var titleLabel: UILabel?
    
    //var btnJustGive: FRAnimatedButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTopBarAttributes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeTrasparent() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
    
    func makeOpaque() {
        self.navigationBar.barTintColor = Constants.color.kAPP_COLOR
        self.navigationBar.isTranslucent = false
    }

    func showNavigationBar() {
        self.isNavigationBarHidden = false
    }
    
    func hideNavigationBar() {
        self.isNavigationBarHidden = true
    }
   
    func setTopBarAttributes() {
        self.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([NSAttributedString.Key.font.rawValue: FontManager.montserratFont(fontName: MontserratFont.regular, size: 18.0), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white])
        self.navigationBar.tintColor = UIColor.white
    }
    
    func setTopBarAttributesAppColor() {
        // This for screens with white background already
        self.navigationBar.tintColor = Constants.color.kAPP_COLOR
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
