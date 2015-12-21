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
//    var textFieldString: String
//    
//    override init() {
//        self.textFieldString = "change this value"
//    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        
        let textAreaAttributes : [String : AnyObject] = [
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSStrokeWidthAttributeName : -3.0,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
        ]
        
        textField.defaultTextAttributes = textAreaAttributes
        textField.textAlignment = .Center
        
        // self.textFieldString = textField.text!
        
//        if let textFieldStringValue = textField.text {
//            self.textFieldString = textFieldStringValue
//            print("String value: " + textFieldStringValue)
//        }
//        
//        print("value: " + toString())
    }
    
    func textFieldDidEndEditing(textField: UITextField) {

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
//    // Getter
//    func toString() -> String {
//        return self.textFieldString
//    }
    
}
