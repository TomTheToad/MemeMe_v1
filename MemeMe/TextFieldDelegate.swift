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
        textField.clearsOnBeginEditing = true
        
        // TODO: Fix this
        // remove placeholder nil?
//        if textField.text == "TOP TEXT" || textField.text == "BOTTOM TEXT" {
//            textField.text = ""
//        }
        
        textField.placeholder = nil
        textField.textAlignment = .Center
        textField.sizeToFit()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
}
