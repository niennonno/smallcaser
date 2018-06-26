//
//  DetailViewController.swift
//  smallcaser
//
//  Created by Aditya Vikram Godawat on 23/06/18.
//  Copyright © 2018 Aditya Vikram Godawat. All rights reserved.
//

import UIKit
import SDWebImage
import Charts

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var oneYearReturnLabel: UILabel!
    @IBOutlet weak var monthlyReturnLabel: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var rantionaleTextView: UITextView!
    
    var smallCase: Smallcase!
    var imageUrl: URL!
    var lineChartEntry = [ChartDataEntry]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem?.title = ""

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Summary"
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: SDWebImageOptions.highPriority, completed: nil)
        self.navigationItem.title = smallCase.name
        indexLabel.text = String(format: "%.02f", smallCase.indexValue)
        oneYearReturnLabel.text = String(format: "%.02f", smallCase.yearlyReturns) + "/year"
        monthlyReturnLabel.text = String(format: "%.02f", smallCase.monthlyReturns) + "/month"
        
        let data = smallCase.rationale.data(using: String.Encoding.unicode)! // mind "!"
        let attrStr = try? NSAttributedString( // do catch
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        // suppose we have an UILabel, but any element with NSAttributedString will do
        rantionaleTextView.attributedText = attrStr
        getData()
    }
    
    func getData() {
        
    }
}
