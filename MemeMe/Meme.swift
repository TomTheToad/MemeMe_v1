//
//  Meme.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 12/19/15.
//  Copyright © 2015 TomTheToad. All rights reserved.
//

import Foundation
import Social

struct Meme {
    
    // Fields
    var topTextField: String
    var bottomTextField: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    init(topTextField: String, bottomTextField: String, originalImage: UIImage, memedImage: UIImage) {
        self.topTextField = topTextField
        self.bottomTextField = bottomTextField
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
    func shareMemeOnFacebook(thisViewController: UIViewController) {
        if(SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)) {
        let facebookController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookController.addImage(memedImage)
            thisViewController.presentViewController(facebookController, animated: true, completion: nil)
        }
    }
    
    func shareMemeOnTwitter(thisViewController: UIViewController) {
        if(SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)) {
            let twitterController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterController.addImage(memedImage)
            thisViewController.presentViewController(twitterController, animated: true, completion: nil)
        }
    }
}