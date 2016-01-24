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
        
        let placeHolderMeme = Meme(
            topTextField: "New",
            bottomTextField: "Meme",
            originalImage: UIImage(named: "plusImage")!,
            memedImage: UIImage(named: "plusImage")!,
            isEditable: false)
        
        
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
    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//        let deleteThisMeme = UITableViewRowAction(style: .Default, title: "Delete!", handler:
//            { action, indexPath in
//                self.deleteMeme(indexPath)
//            })
//        
//        // reload Data
//        tableView.reloadData()
//        
//        // done editing
//        tableView.editing = false
//        
//        let actions = [deleteThisMeme]
//        return actions
//    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            if numberOfMemes > 0 {
                deleteMeme(indexPath)
            } else {
                print("unable to delete")
            }
        }
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if numberOfMemes > 0 {
//            guard memes![indexPath.row].isEditable == true else {
//                
//                return
//            }
//            
//            deleteMeme(indexPath)
//            
//        } else {
//            let alert = UIAlertController(title: "Not Found", message: "Undable to delete Meme", preferredStyle: UIAlertControllerStyle.Alert)
//            presentViewController(alert, animated: true, completion: nil)
//        }
//    }
    
    @IBAction func unWindToTable(segue: UIStoryboardSegue) {
        
    }
}