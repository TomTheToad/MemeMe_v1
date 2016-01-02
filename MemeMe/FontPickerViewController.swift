//
//  FontPickerViewController.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 12/26/15.
//  Copyright © 2015 TomTheToad. All rights reserved.
//
// Class that allows user to choose a font and font size
// then returns that selection to the main ViewController
// Populates the pickers fields with existing font and size.

import UIKit

class FontPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Fields
    var fontNamesArray: [String] = []
    var fontsDictionary: [String: UIFont] = [:]
    var selectedFontSize: CGFloat?
    var selectedFont: UIFont?
    var meme: Meme?
    
    
    // IBOutlets
    @IBOutlet weak var fontPicker: UIPickerView!
    @IBOutlet weak var fontSizeLabel: UITextField!
    @IBOutlet weak var fontSizeSlider: UISlider!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Poll system for fonts
        populateFonts()
        
        // Check for previously selected font size and set assicoated UIlabel
        if let thisFontSize = selectedFontSize {
            fontSizeLabel.text = String(thisFontSize)
            fontSizeSlider.value = Float(thisFontSize)
        }
        
        // Configure fontpicker UI object
        fontPicker.dataSource = self
        fontPicker.delegate = self
        
        // Check for previously selected font and set fontpicker
        if let thisFont = selectedFont {
            if fontNamesArray.contains(thisFont.familyName){
                let indexOfFont = fontNamesArray.indexOf(thisFont.familyName)
                fontPicker.selectRow(indexOfFont!, inComponent: 0, animated: true)
            }
        }
    }
    
    // Poll the system for available fonts and save for use
    func populateFonts() {
        let fontFamilies = UIFont.familyNames()
        
        for familyName in fontFamilies {
            fontNamesArray.append(familyName)
            fontsDictionary[familyName] = UIFont(name: familyName, size: 40)!
            }
        fontNamesArray.sortInPlace()
    }
    
    // Begin required UIPickerView methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontNamesArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fontNamesArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Find the selected font in the dictionary using the name from the picker array.
        selectedFont = fontsDictionary[fontNamesArray[row]]!
    }
    
    // Check for font slider change and update value
    // TODO: Choose to keep slider or add wheel on font picker for version 2?
    @IBAction func fontSizeSliderHasChanged(sender: AnyObject) {
        let newFontSize = fontSizeSlider.value
        
        fontSizeLabel.text = newFontSize.description
        selectedFontSize = CGFloat(newFontSize)
    }
    
    // Pass seleced values to main view controller "ViewController"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "fontChosen") {
            let MainVC:ViewController = segue.destinationViewController as! ViewController
            MainVC.receivedFont = selectedFont
            MainVC.receivedFontSize = selectedFontSize
            MainVC.recievedMeme = meme
        }
    }
}
