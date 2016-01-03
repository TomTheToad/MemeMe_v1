//
//  ViewController.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 12/6/15.
//  Copyright © 2015 TomTheToad. All rights reserved.
//
// The initial view controller for a Meme creation tool.
// Allows user to choose and image by camera or album.
// Allows user to enter text in two possible text fields.
// Allows user to share Meme via activity view.
// Saves Meme to allow for in app persistence.

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
    
    
    // Check for received attributes and set appropriately
    func setFontAttributes() -> [String: AnyObject] {
        
        // check for received font size and set
        if let newFontSize = receivedFontSize {
            fontSize = newFontSize
        } else {
            fontSize = 40.0
        }
        
        // check for received font and set
        if let newFont = receivedFont {
            font = UIFont(name: newFont.fontName, size: fontSize!)
        } else {
            font = UIFont(name: "HelveticaNeue-CondensedBlack", size: fontSize!)
        }
        
        // check for received font color and set
        // TODO: add color picker for version 2
        if let newFontColor = receivedFontColor {
            fontColor = newFontColor
        } else {
            fontColor = UIColor.blackColor()
        }
        
        // check for received stroke color and set
        if let newStrokeColor = receivedStrokeColor {
            strokeColor = newStrokeColor
        } else {
            strokeColor = UIColor.whiteColor()
        }
        
                let textAttributes : [String : AnyObject] = [
                    NSFontAttributeName : font!,
                    NSStrokeColorAttributeName : strokeColor!,
                    NSStrokeWidthAttributeName : -3.0,
                    NSForegroundColorAttributeName : fontColor!,
                ]
        return textAttributes
    }
    
    
    /* Image choice methods */
    @IBAction func chooseImageFromLibrary(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func chooseImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            backgroundImage.contentMode = .ScaleAspectFit
            backgroundImage.image = selectedImage
            enableShareButton()
            backgroundImage.backgroundColor = UIColor.blackColor()
            
        }
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbars
        topToolBar.hidden = false
        bottomToolbar.hidden = false
        // Set background to original color
        view.backgroundColor = originalViewBG
        
        return memedImage
    }
    
    // Method for saving the current Meme
    // TODO: Version two expand to include coloring
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
        
        if let thisImage = backgroundImage.image {
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
        view.frame.origin.y -= getKeyboardHeight(notification)
        } else if topTextField.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    func keyBoardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
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
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    // Prepare for and present Font Picker View Controller
    @IBAction func modifyFont(sender: AnyObject) {
        let FontViewController: FontPickerViewController = storyboard?.instantiateViewControllerWithIdentifier("FontPickerViewController") as! FontPickerViewController
        
        // Save Meme and pass to picker view controller
        let meme = saveMeme()
        
        FontViewController.selectedFontSize = fontSize
        FontViewController.selectedFont = font
        FontViewController.meme = meme
        
        // TODO: add other attributes
        FontViewController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        
        presentViewController(FontViewController, animated: true, completion: nil)
    }
    
    // Add an existing Meme if one is available
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
    
    // Enable share button if conditions exist
    func enableShareButton() {
        if let BG = backgroundImage {
            if BG.image != UIImage(named: "defaultImage") {
                shareButton.enabled = true
            }
        }
    }
}

