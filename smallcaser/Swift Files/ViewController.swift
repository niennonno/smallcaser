//
//  ViewController.swift
//  smallcaser
//
//  Created by Aditya Vikram Godawat on 22/06/18.
//  Copyright © 2018 Aditya Vikram Godawat. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = ""
        

    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smallcaseIds.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let smallcaseId = smallcaseIds[indexPath.item]
        
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        
        collectionViewCell.imageView.sd_setImage(with: URL(string: imageUrl+smallcaseId+".png"), placeholderImage: UIImage(), options: SDWebImageOptions.highPriority, completed: nil)
        
        return collectionViewCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        let detailViewController = StoryboardScene.Main.detailViewController.instantiate()
        self.navigationController?.pushViewController(detailViewController, animated: true)

    }
}
