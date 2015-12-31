//
//  ViewController.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 12/6/15.
//  Copyright © 2015 TomTheToad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // Fields
    var fontSize = CGFloat?()
    var font = UIFont?()
    var fontColor = UIColor?()
    var strokeColor = UIColor?()
    
    var receivedFont = UIFont?()
    var receivedFontSize = CGFloat?()
    var receivedFontColor = UIColor?()
    var receivedStrokeColor = UIColor?()
    
    var recievedMeme = Meme?()

    
    // IBOutlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cameraToolBarButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var fontButton: UIBarButtonItem!
    
    
    // Delegates
    let topTextFieldDelegate = TextFieldDelegate()
    let bottomTextFieldDelegate = TextFieldDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check for camera and enable if available
        cameraToolBarButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Get text field attributes
        let attributes = setFontAttributes()
        
        // Check for existing Meme info
        checkForMeme()
        
        // Set text field attributes
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP TEXT", attributes: attributes)
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM TEXT", attributes: attributes)
        topTextField.defaultTextAttributes = attributes
        bottomTextField.defaultTextAttributes = attributes
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        
        // Assign text field delegates
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
    
    
    // Check for recieved attributes and set appropirately
    func setFontAttributes() -> [String: AnyObject] {
        
        // check for received font size and set
        if let newFontSize = self.receivedFontSize {
            self.fontSize = newFontSize
        } else {
            self.fontSize = 40.0
        }
        
        // check for received font and set
        if let newFont = self.receivedFont {
            self.font = UIFont(name: newFont.fontName, size: self.fontSize!)
        } else {
            self.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: self.fontSize!)
        }
        
        // check for received font color and set
        if let newFontColor = receivedFontColor {
            self.fontColor = newFontColor
        } else {
            self.fontColor = UIColor.blackColor()
        }
        
        // check for received stroke color and set
        if let newStrokeColor = receivedStrokeColor {
            self.strokeColor = newStrokeColor
        } else {
            self.strokeColor = UIColor.whiteColor()
        }
        
                let textAttributes : [String : AnyObject] = [
                    NSFontAttributeName : self.font!,
                    NSStrokeColorAttributeName : self.strokeColor!,
                    NSStrokeWidthAttributeName : -3.0,
                    NSForegroundColorAttributeName : self.fontColor!,
                ]
        return textAttributes
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
            backgroundImage.contentMode = .ScaleAspectFit
            self.backgroundImage.image = selectedImage
            enableShareButton()
            backgroundImage.backgroundColor = UIColor.blackColor()
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /* Meme save methods */
    func generateMemedImage() -> UIImage {
        // Save view background color
        let originalViewBG = view.backgroundColor
        
        // Hide toolbars
        topToolBar.hidden = true
        bottomToolbar.hidden = true
        view.backgroundColor = UIColor.blackColor()
        
        // Render image from view
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbars
        topToolBar.hidden = false
        bottomToolbar.hidden = false
        view.backgroundColor = originalViewBG
        
        return memedImage
    }
    
    func saveMeme() -> Meme {
        // Fields
        var topString = ""
        var bottomString = ""
        var bgImage = UIImage(named: "defaultImage")
        
        if let topTextFieldString = topTextField.text {
            topString = topTextFieldString
        }
        
        if let bottomTextFieldString = bottomTextField.text {
            bottomString = bottomTextFieldString
        }
        
        if let thisImage = self.backgroundImage.image {
            bgImage = thisImage
        }
        
        let meme = Meme(
            topTextField: topString,
            bottomTextField: bottomString,
            originalImage: bgImage!,
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
    
    @IBAction func shareMeme(sender: AnyObject) {
        let meme = saveMeme()
        let memeToShare = [meme.memedImage]
        let activityViewController = UIActivityViewController(activityItems: memeToShare, applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func modifyFont(sender: AnyObject) {
        let FontViewController: FontPickerViewController = storyboard?.instantiateViewControllerWithIdentifier("FontPickerViewController") as! FontPickerViewController
        
        let meme = saveMeme()
        
        FontViewController.selectedFontSize = self.fontSize
        FontViewController.selectedFont = self.font
        FontViewController.meme = meme
        
        // TODO: add other attributes
        
        FontViewController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        
        presentViewController(FontViewController, animated: true, completion: nil)
    }
    
    func checkForMeme() {
        if let thisMeme = recievedMeme {
            topTextField.text = thisMeme.topTextField
            bottomTextField.text = thisMeme.bottomTextField
            backgroundImage.contentMode = .ScaleAspectFit
            backgroundImage.image = thisMeme.originalImage
            backgroundImage.backgroundColor = UIColor.blackColor()
            enableShareButton()
        }
    }
    
    func enableShareButton() {
        if let BG = backgroundImage {
            if BG.image != UIImage(named: "defaultImage") {
                shareButton.enabled = true
            }
        }
    }
}

