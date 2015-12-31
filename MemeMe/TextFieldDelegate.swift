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
    
    override init() {
        self.fontSize = 40.0
        self.fontColor = UIColor.whiteColor()
        self.strokeColor = UIColor.blackColor()
        self.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: self.fontSize)!
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        
        let textAreaAttributes : [String : AnyObject] = [
            NSFontAttributeName : font,
            NSStrokeColorAttributeName : strokeColor,
            NSStrokeWidthAttributeName : -3.0,
            NSForegroundColorAttributeName : fontColor,
        ]
        
        textField.defaultTextAttributes = textAreaAttributes
        textField.textAlignment = .Center
        
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
