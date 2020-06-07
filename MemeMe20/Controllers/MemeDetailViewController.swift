//
//  MemeDetailViewController.swift
//  MemeMe20
//
//  Created by Paul Cristian Percca Julca on 6/6/20.
//  Copyright © 2020 Innovatrix. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var memeIndex: Int!
    @IBOutlet weak var memedImage: UIImageView!
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memedImage.image = memes[memeIndex].memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editMeme))
    }
    
    // MARK: - MemeMe Methods
    
    @objc func editMeme(){
        let memeEditorController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        memeEditorController.memeIndex = memeIndex
        present(memeEditorController, animated: true, completion: nil)
    }

    
    
}
