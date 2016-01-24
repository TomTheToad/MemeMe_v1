//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 1/19/16.
//  Copyright © 2016 TomTheToad. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Fields
    var memes: [Meme]? {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    var numberOfMemes = 0
    
    // IBOutlets
    @IBOutlet weak var collectionTableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.collectionTableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Set number of rows based on if any memes yet exist
        if let memes = memes {
            numberOfMemes = memes.count
        }
        
        if numberOfMemes > 0 {
            return memes!.count
        } else {
            return 1
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell", forIndexPath: indexPath) as! MemeTableViewCell
        
        // place holder for memes if none exist
        let placeHolderMeme = Meme(
            topTextField: "New",
            bottomTextField: "Meme",
            originalImage: UIImage(named: "plusImage")!,
            memedImage: UIImage(named: "plusImage")!,
            isEditable: false)
        
        
        // logic to determine if placeholder cell is needed
        if numberOfMemes > 0 {
            if let meme = memes {
            
                cell.meme = meme[indexPath.row]
            }

        } else {
            
            cell.meme = placeHolderMeme
        }

        return cell
    }
    
    func newMeme() {
        var editorVC: MemeEditorViewController
        editorVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditor") as! MemeEditorViewController
        
        presentViewController(editorVC, animated: true, completion: nil)
    }
    
    func editMeme(meme: Meme, indexPath: NSIndexPath) {
        var editorVC: MemeEditorViewController
        editorVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditor") as! MemeEditorViewController
        editorVC.recievedMeme = meme
        editorVC.newMeme = false
        editorVC.memeIndexPath = indexPath
        
        presentViewController(editorVC, animated: true, completion: nil)
    }
    
    func deleteMeme(indexPath: NSIndexPath) {
        
        // create link to AppDelegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        
        appDelegate.memes.removeAtIndex(indexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // verify cell is marked editable.
        // created to allow protection of placeholder and any example cell
        if numberOfMemes > 0 {
            guard memes![indexPath.row].isEditable == true else {
                newMeme()
                return
            }
            
            editMeme(memes![indexPath.row], indexPath: indexPath)

        } else {
            newMeme()
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            if numberOfMemes > 0 {
                deleteMeme(indexPath)
                tableView.reloadData()
            } else {
                // TODO: disable delete or add alert?
                print("unable to delete")
            }
        }
    }
    
    // allows method for reaching when calling view is not in nav stack.
    @IBAction func unWindToTable(segue: UIStoryboardSegue) {
        
    }
}
