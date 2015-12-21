//
//  ViewController.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 12/6/15.
//  Copyright © 2015 TomTheToad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // IBOutlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cameraToolBarButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // Delegates
    let topTextFieldDelegate = TextFieldDelegate()
    let bottomTextFieldDelegate = TextFieldDelegate()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraToolBarButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    /* Image choice methods */
    
    @IBAction func chooseImageFromLibrary(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func chooseImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            backgroundImage.contentMode = .ScaleAspectFill
            self.backgroundImage.image = selectedImage
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
        shareButton.enabled = true
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /* Meme save methods */
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbars
        topToolBar.hidden = true
        bottomToolbar.hidden = true
        
        // Render image from view
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbars
        topToolBar.hidden = false
        bottomToolbar.hidden = false
        
        return memedImage
    }
    
    func saveMeme() -> Meme {
        // Fields
        var topString = ""
        var bottomString = ""
        
        if let topTextFieldString = topTextField.text {
            topString = topTextFieldString
        }
        
        if let bottomTextFieldString = bottomTextField.text {
            bottomString = bottomTextFieldString
        }
        
        let meme = Meme(
            topTextField: topString,
            bottomTextField: bottomString,
            originalImage: (self.backgroundImage.image)!,
            memedImage: generateMemedImage())
        
        return meme
    }
    
    /* View slide for keyboard methods */
    
    func keyBoardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
        } else if topTextField.isFirstResponder() {
            self.view.frame.origin.y = 0
        }
    }
    
    func keyBoardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
}

