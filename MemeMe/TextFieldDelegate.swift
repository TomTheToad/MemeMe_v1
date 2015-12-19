//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 12/16/15.
//  Copyright © 2015 TomTheToad. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
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
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
//        let font = UIFont(name: "Verdana", size: 54.0)
//
//        let enteredText = textField.text!
//        let mutableEnteredText = NSMutableAttributedString(
//            string: enteredText,
//            attributes: [
//                NSFontAttributeName: font!,
//                NSStrokeColorAttributeName: UIColor.blackColor(),
//                NSStrokeWidthAttributeName: -4.0,
//                NSForegroundColorAttributeName: UIColor.whiteColor(),
//                
//            ])
//        
//        textField.attributedText = mutableEnteredText

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
}
