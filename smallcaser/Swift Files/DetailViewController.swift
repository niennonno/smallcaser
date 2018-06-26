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
    var scId: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem?.title = ""

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Summary"
        setupView()
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
        rantionaleTextView.attributedText = attrStr
        getData()
    }
    
    func getData() {
        ChartData.getChartData(scId) { (charData, error) in
            if error != nil {
            } else {
                self.fillData(charData!)
            }
        }
    }
    
    func fillData(_ charData: [ChartData]) {
        for data in charData {

            let chartData = ChartDataEntry(x: data.date.timeIntervalSince1970, y: data.index)
            lineChartEntry.append(chartData)
        }
        let line = LineChartDataSet(values: lineChartEntry, label: "Values")
        line.drawCirclesEnabled = false
        line.colors = [.black]
        let data = LineChartData()
        data.addDataSet(line)
        chartView.data = data
        chartView.chartDescription?.text = ""
        chartView.xAxis.labelPosition = .bottom
        chartView.isUserInteractionEnabled = true
        chartView.xAxis.valueFormatter = DateValueFormatter()
    }
}

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "dd/MM/yy"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
