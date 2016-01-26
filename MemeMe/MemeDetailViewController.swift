//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 1/24/16.
//  Copyright © 2016 TomTheToad. All rights reserved.
//
// Detail View for individual Memes once selected in collection
// Allows user to edit presented meme via "edit" button

import UIKit

class MemeDetailViewController: UIViewController {

    // Fields
    var receivedMeme: Meme?
    var receivedIndexPath: NSIndexPath?
    
    // IBOutlet
    @IBOutlet weak var memedImage: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        
        // add "edit" button to edit presented meme -> goes to meme editor
        let editButton: UIBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editMeme:")
        
        title = "Meme Detail"
        navigationItem.rightBarButtonItem = editButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let meme = receivedMeme {
            memedImage.image = meme.memedImage
        }
        
    }
    
    // sends current meme to meme editor
    @IBAction func editMeme(sender: UIBarButtonItem) {
        var editorVC: MemeEditorViewController
        editorVC = storyboard?.instantiateViewControllerWithIdentifier("MemeEditor") as! MemeEditorViewController
        editorVC.recievedMeme = receivedMeme
        editorVC.newMeme = false
        editorVC.memeIndexPath = receivedIndexPath
        
        presentViewController(editorVC, animated: false, completion: nil)
    }
}
