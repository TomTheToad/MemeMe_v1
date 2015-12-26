//
//  FontUtility.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 12/25/15.
//  Copyright © 2015 TomTheToad. All rights reserved.
//

import Foundation
import UIKit

// TODO: more descriptive class name?
class FontUtility {
    
    var fontListAsStrings: [[String]]
    
    init() {
        self.fontListAsStrings = []
    }
    
    func populateAvailableFontFamilies() {
        let fontFamilies = UIFont.familyNames()
        for familyName in fontFamilies {
            self.fontListAsStrings.append(UIFont.fontNamesForFamilyName(familyName))
        }
    }
}