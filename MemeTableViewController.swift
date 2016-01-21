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
            memedImage: UIImage(named: "plusImage")!)
        
        if numberOfMemes > 0 {
            if let meme = memes {
            
                cell.meme = meme[indexPath.row]
            }

        } else {
            
            cell.meme = placeHolderMeme

        }

        return cell
    }
}
