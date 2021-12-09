//
//  HMTextField.swift
//  SubscriptBea
//
//  Created by Harshit on 26/11/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//


import Foundation
import UIKit

enum TextFieldInputType {
    case EmailAddress
    case Password
    case Zipcode
    case Name
    case Username
    case PhoneNumber
    case WebsiteURL
    case Price
    case Quantity
    case DOB
    case Other
    case Search
    case DateTime
}

@objc protocol HMTextFieldDelegate {
    @objc optional func textFieldDidEndEditing(_ textField: HMTextField)
    @objc optional func textField(_ textField: HMTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)
    @objc optional func myTextFieldDidChange(_ textField: HMTextField)
}

@IBDesignable
class HMTextField: UITextField, UITextFieldDelegate {
    
    var hsDelegate: HMTextFieldDelegate?

    var padding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    
    var inputType: TextFieldInputType = .Other {
        didSet {
            setupTextField()
        }
    }
    
    var showClearButton: Bool = true {
        didSet {
            setupTextField()
        }
    }
    
    @IBInspectable var rightViewImage: UIImage? = nil {
        didSet {
            if rightViewImage == nil {
                self.leftView = nil
                padding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
            } else {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
                let imageView = UIImageView(image: rightViewImage)
                imageView.contentMode = .scaleAspectFit
                view.addSubview(imageView)
                imageView.frame = view.bounds
                imageView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                view.backgroundColor = UIColor.clear
                self.leftView = view
                self.leftViewMode = .always
                
                padding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 40)
            }
            
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var leftViewImage: UIImage? = nil {
        didSet {
            if leftViewImage == nil {
                self.leftView = nil
                padding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
            } else {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
                let imageView = UIImageView(image: leftViewImage)
                imageView.contentMode = .scaleAspectFit
                view.addSubview(imageView)
                imageView.frame = view.bounds
                imageView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                view.backgroundColor = UIColor.clear
                self.leftView = view
                self.leftViewMode = .always
                
                padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
            }
            
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var rightViewCustom: UIView? = nil {
        didSet {
            if rightViewCustom == nil {
                self.rightView = nil
                padding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
            } else {
                self.rightView = rightViewCustom
                self.rightViewMode = .always
                
                padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
            }
            
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var allowedCharacters: String = "" {
        didSet {
            
        }
    }
    
    @IBInspectable var maxLength: Int = Constants.TextLength.GenericMaxTextLength {
        didSet {
            
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = cornerRadius
    }
    
    func setupTextField() {
        self.isSecureTextEntry = false
        self.keyboardType = UIKeyboardType.default
        self.maxLength = Constants.TextLength.GenericMaxTextLength
        self.autocapitalizationType = .sentences
        self.autocorrectionType = .no
        self.allowedCharacters = ""
        self.characterSet = nil
        
        if showClearButton {
            self.clearButtonMode = .whileEditing
        } else {
            self.clearButtonMode = .never
        }
        
        if inputType == .EmailAddress {
            self.keyboardType = .emailAddress
            self.maxLength = Constants.TextLength.GenericMaxTextLength
            self.characterSet = Constants.CharacterSets.SpaceCharacterSetInverted
            self.autocapitalizationType = .none
        } else if inputType == .Name {
            self.keyboardType = .default
            self.maxLength = Constants.TextLength.GenericMaxTextLength
            self.allowedCharacters = ""
            self.autocapitalizationType = .words
        } else if inputType == .Username {
            self.keyboardType = .default
            self.maxLength = Constants.TextLength.GenericMaxTextLength
            self.characterSet = Constants.CharacterSets.SpaceCharacterSetInverted
            self.autocapitalizationType = .none
        } else if inputType == .Password {
            self.keyboardType = .default
            self.isSecureTextEntry = true
            self.maxLength = Constants.TextLength.PasswordMaxLength
            self.characterSet = Constants.CharacterSets.SpaceCharacterSetInverted
            self.autocapitalizationType = .none
        } else if inputType == .PhoneNumber {
            self.keyboardType = .phonePad
            self.maxLength = Constants.TextLength.PhoneNumberMaxLength
            self.allowedCharacters = Constants.AcceptableCharacters.PhoneNumber
        } else if inputType == .Zipcode {
            self.keyboardType = .numberPad
            self.maxLength = Constants.TextLength.ZipCodeMaxLength
            self.allowedCharacters = Constants.AcceptableCharacters.OnlyNumbers
        } else if inputType == .WebsiteURL {
            self.keyboardType = .URL
            self.maxLength = Constants.TextLength.NoLimit
            self.autocapitalizationType = .none
        } else if inputType == .Price {
            self.keyboardType = .numberPad
            self.maxLength = Constants.TextLength.PriceMaxLength
            self.allowedCharacters = Constants.AcceptableCharacters.OnlyNumbers
        } else if inputType == .Quantity {
            self.keyboardType = .numberPad
            self.maxLength = Constants.TextLength.QuantityMaxLength
            self.allowedCharacters = Constants.AcceptableCharacters.OnlyNumbers
        } else if inputType == .Other {
            self.keyboardType = .default
            self.maxLength = Constants.TextLength.GenericMaxTextLength
            self.allowedCharacters = ""
        }  else if inputType == .Search {
            self.keyboardType = .asciiCapable
            self.maxLength = Constants.TextLength.GenericMaxTextLength
            self.allowedCharacters = "+ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 "
        }
    }
    
    var characterSet: CharacterSet?
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeTextField()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeTextField()
    }
    
    func initializeTextField() {
        self.textColor = UIColor.black
        self.tintColor = self.textColor!
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes:[NSAttributedString.Key.foregroundColor: Constants.color.kTEXTFIELD_PLACEHOLDER_COLOR])
        self.delegate = self
        self.font = FontManager.montserratFont(fontName: .semiBold, size: 16)
        self.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - UITextField Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.hsDelegate?.textField?(self, shouldChangeCharactersIn: range, replacementString: string)
        
        let newLength = textField.text!.count + string.count - range.length
        
        if newLength <= maxLength {
            
            if inputType == .Quantity {
                if newLength == 1 && string == "0" {
                    // 0 initially is not allowed if its a quantity type
                    return false
                }
            }
            
            if characterSet != nil {
                
                let arrfiltered = string.components(separatedBy: characterSet!.inverted) as NSArray
                
                let filtered = arrfiltered.componentsJoined(by: "")
                
                return string == filtered
            } else if allowedCharacters == "" {
                // Default. All characters are allowed.
                return true
            } else {
                
                let cs = CharacterSet(charactersIn: allowedCharacters).inverted
                
                let arrfiltered = string.components(separatedBy: cs) as NSArray
                
                let filtered = arrfiltered.componentsJoined(by: "")
                
                return string == filtered
            }
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.trimmedString()
        hsDelegate?.textFieldDidEndEditing?(self)
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        hsDelegate?.myTextFieldDidChange?(self)
    }
}
