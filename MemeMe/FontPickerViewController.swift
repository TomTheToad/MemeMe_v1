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
    var selectedFont: UIFont = UIFont(name: "Copperplate", size: 40)!
    
    // IBOutlets
    @IBOutlet weak var fontPicker: UIPickerView!
    
    override func viewWillAppear(animated: Bool) {
        populateFonts()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fontPicker.dataSource = self
        fontPicker.delegate = self
        fontPicker.selectRow(10, inComponent: 0, animated: true)

        // Do any additional setup after loading the view.
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
        
//        print("fontNamesArray value= " + fontNamesArray[row])
//        print("selected font from dict= " + String(selectedFont))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "fontChosen") {
            let MainVC:ViewController = segue.destinationViewController as! ViewController
            MainVC.recievedFont = selectedFont
        }
    }
}
