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
    
    override init() {
        self.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        
        let textAreaAttributes : [String : AnyObject] = [
            NSFontAttributeName : font,
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSStrokeWidthAttributeName : -3.0,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
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
