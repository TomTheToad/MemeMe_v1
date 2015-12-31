//
//  FontPickerViewController.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 12/26/15.
//  Copyright © 2015 TomTheToad. All rights reserved.
//

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
        
        populateFonts()
        
        if let thisFontSize = selectedFontSize {
            fontSizeLabel.text = String(thisFontSize)
            fontSizeSlider.value = Float(thisFontSize)
        }
        
        fontPicker.dataSource = self
        fontPicker.delegate = self
        
        if let thisFont = selectedFont {
            if fontNamesArray.contains(thisFont.familyName){
                let indexOfFont = fontNamesArray.indexOf(thisFont.familyName)
                fontPicker.selectRow(indexOfFont!, inComponent: 0, animated: true)
            }
        }
    }
    
    func populateFonts() {
        let fontFamilies = UIFont.familyNames()
        
        for familyName in fontFamilies {
            fontNamesArray.append(familyName)
            fontsDictionary[familyName] = UIFont(name: familyName, size: 40)!
            }
        fontNamesArray.sortInPlace()
    }
    
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
        selectedFont = fontsDictionary[fontNamesArray[row]]!
    }
    
    @IBAction func fontSizeSliderHasChanged(sender: AnyObject) {
        let newFontSize = fontSizeSlider.value
        
        fontSizeLabel.text = newFontSize.description
        selectedFontSize = CGFloat(newFontSize)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "fontChosen") {
            let MainVC:ViewController = segue.destinationViewController as! ViewController
            MainVC.recievedFont = selectedFont
            MainVC.recievedFontSize = selectedFontSize
            MainVC.recievedMeme = meme
        }
    }
}
