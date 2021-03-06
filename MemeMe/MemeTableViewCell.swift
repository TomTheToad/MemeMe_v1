//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 1/19/16.
//  Copyright © 2016 TomTheToad. All rights reserved.
//

import UIKit

// custom table view cell for meme table
class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var topTextField: UILabel!
    @IBOutlet private weak var bottomTextField: UILabel!
    @IBOutlet private weak var backgroundImage: UIImageView!
    
    var meme: Meme? {
        didSet {
            if let meme = meme {
                topTextField.text = meme.topTextField
                bottomTextField.text = meme.bottomTextField
                backgroundImage.image = meme.memedImage
            }
        }
    }
}
