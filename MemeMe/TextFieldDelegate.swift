//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 12/16/15.
//  Copyright © 2015 TomTheToad. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // Fields
    var font: UIFont
    var fontSize: CGFloat
    var fontColor: UIColor
    var strokeColor: UIColor
    
//    override init() {
//        self.fontSize = 40.0
//        self.fontColor = UIColor.whiteColor()
//        self.strokeColor = UIColor.blackColor()
//        self.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: self.fontSize)!
//    }
    
    convenience override init() {
        self.init(thisTextField: nil)
    }
    
    init(thisTextField: UITextField?) {
        self.fontSize = 40.0
        self.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: self.fontSize)!
        self.fontColor = UIColor.whiteColor()
        self.strokeColor = UIColor.blackColor()
        super.init()
        
        
        let textAreaAttributes : [String : AnyObject] = [
            NSFontAttributeName : self.font,
            NSStrokeColorAttributeName : self.strokeColor,
            NSStrokeWidthAttributeName : -3.0,
            NSForegroundColorAttributeName : self.fontColor,
        ]
        
        thisTextField!.defaultTextAttributes = textAreaAttributes
        thisTextField!.textAlignment = .Center
    }
    
    convenience init(newTextField: UITextField?) {
        self.init(thisTextField: newTextField)
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    func setNewFont(newFont: UIFont) {
        self.font = newFont
    }
    
    func returnToDefaultFont() {
        self.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    }
}
