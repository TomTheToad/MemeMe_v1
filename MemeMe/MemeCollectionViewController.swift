//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 1/19/16.
//  Copyright © 2016 TomTheToad. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Fields
    var memes: [Meme]? {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    var numberOfMemes = 0
    
    // IBOutlets
    @IBOutlet weak var collectionGridView: UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        collectionGridView.reloadData()
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let memes = memes {
            numberOfMemes = memes.count
        }
        
        if numberOfMemes > 0 {
            return memes!.count
        } else {
            return 1
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
//        cell.meme = memes[indexPath.row]
//        return cell
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
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
    
    @IBAction func unWindToCollection(segue: UIStoryboardSegue) {
        
    }
}
