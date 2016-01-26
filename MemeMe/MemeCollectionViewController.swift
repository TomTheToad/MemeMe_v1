//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by VICTOR ASSELTA on 1/19/16.
//  Copyright © 2016 TomTheToad. All rights reserved.
//
// Meme collection view
// Presents user with all sent memes in a 3 horizontal gird layout
// User can add a new meme via select placeholder cell or "plus" button
// User can view an existing meme via select collection item.

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
        
        // reload to keep table up to date
        collectionGridView.reloadData()
        
        // add plus(add meme) button to navigation bar
        let plusButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "newMeme")
        
        navigationItem.rightBarButtonItem = plusButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // begin set layout for collection
        let spacing: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * spacing)) / 3.0
        
        let layout = collectionGridView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSizeMake(dimension, dimension)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // set number of rows based on existence of any memes
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
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        // placeholder if no memes yet exist
        let placeHolderMeme = Meme(
            topTextField: "New",
            bottomTextField: "Meme",
            originalImage: UIImage(named: "plusImage")!,
            memedImage: UIImage(named: "plusImage")!,
            isEditable: false)

        // determine if placeholder is necessary
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
        editorVC = storyboard?.instantiateViewControllerWithIdentifier("MemeEditor") as! MemeEditorViewController
        
        presentViewController(editorVC, animated: true, completion: nil)
    }
    
    // send meme to detail view
    func showMemeDetail(meme: Meme, indexPath: NSIndexPath) {
        var memeDetailVC: MemeDetailViewController
        memeDetailVC = storyboard?.instantiateViewControllerWithIdentifier("memeDetailView") as! MemeDetailViewController
        memeDetailVC.receivedMeme = meme
        memeDetailVC.receivedIndexPath = indexPath
        
        navigationController!.pushViewController(memeDetailVC, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // determine if meme can be edited.
        // if not, assume placeholder, create new meme.
        if numberOfMemes > 0 {
            guard memes![indexPath.row].isEditable == true else {
                newMeme()
                return
            }
            
            showMemeDetail(memes![indexPath.row], indexPath: indexPath)
            
        } else {
            newMeme()
        }
    }
    
    @IBAction func unWindToCollection(segue: UIStoryboardSegue) {
        
    }
}
