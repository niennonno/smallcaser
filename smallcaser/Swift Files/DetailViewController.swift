//
//  DetailViewController.swift
//  smallcaser
//
//  Created by Aditya Vikram Godawat on 23/06/18.
//  Copyright © 2018 Aditya Vikram Godawat. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem?.title = ""

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Summary"
        
        // Do any additional setup after loading the view.
    }
}
