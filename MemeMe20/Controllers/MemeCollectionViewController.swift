//
//  MemeCollectionViewController.swift
//  MemeMe20
//
//  Created by Paul Cristian Percca Julca on 6/2/20.
//  Copyright © 2020 Innovatrix. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
        
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        orderCells(width: view.frame.size.width, height: view.frame.size.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView!.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(rotateScreen), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    // MARK: - MemeTableViewController Delegate Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        if !memes.isEmpty {
            let meme = memes[(indexPath as NSIndexPath).row]
            cell.memedImage.image = meme.memedImage
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailController.memeIndex = (indexPath as NSIndexPath).row
        self.navigationController!.pushViewController(memeDetailController, animated: true)
    }
    
    // MARK: - MemeMe Methods
    
    @IBAction func openMemeEditor(_ sender: Any) {
        let memeEditorController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        present(memeEditorController, animated: true, completion: nil)
    }
  
    // MARK: - Order Cells Methods
    
    @objc func rotateScreen () {
        var width = view.frame.size.width
        var height = view.frame.size.height
        if !(self.isViewLoaded && self.view.window != nil) {
            width = view.frame.size.height
            height = view.frame.size.width
        }
        orderCells(width: width, height: height)
    }
    
    func orderCells(width: CGFloat, height: CGFloat) {
        let space:CGFloat = 3.0
        var columns:CGFloat = 3.0
        if  width > height {
            columns = 5.0
        } else {
            columns = 3.0
        }
        let dimension = (width - ((columns - 1) * space)) / columns
        flowLayout.itemSize = CGSize(width: dimension, height: dimension * 0.8)
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
    }
}
