//
//  Meme.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 12/19/15.
//  Copyright © 2015 TomTheToad. All rights reserved.
//

import UIKit

struct Meme {
    
    // Fields
    var topTextField: String
    var bottomTextField: String
    var originalImage: UIImage
    var memedImage: UIImage // TODO: check for correct type
    
    init(topTextField: String, bottomTextField: String, originalImage: UIImage, memedImage: UIImage) {
        self.topTextField = topTextField
        self.bottomTextField = bottomTextField
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}