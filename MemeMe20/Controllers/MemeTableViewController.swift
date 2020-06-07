//
//  MemeTableViewController.swift
//  MemeMe20
//
//  Created by Paul Cristian Percca Julca on 6/2/20.
//  Copyright © 2020 Innovatrix. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
        tableView!.rowHeight = 100
    }
    
    // MARK: - MemeTableViewController Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        if !memes.isEmpty {
            let meme = memes[(indexPath as NSIndexPath).row]
            cell.memedText.text = meme.topText + " ... " + meme.bottomText
            cell.memedImage.image = meme.memedImage
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailController.memeIndex = (indexPath as NSIndexPath).row
        self.navigationController!.pushViewController(memeDetailController, animated: true)
    }
    
    // MARK: - MemeMe Methods
    
    @IBAction func openMemeEditor(_ sender: Any) {      
        let memeEditorController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        present(memeEditorController, animated: true, completion: nil)
    }
    
}
