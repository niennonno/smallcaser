//
//  smallcase.swift
//  smallcaser
//
//  Created by Aditya Vikram Godawat on 23/06/18.
//  Copyright © 2018 Aditya Vikram Godawat. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Smallcase: NSObject {

    var scId: String!
    var name: String!
    var type: String!
    var rationale: String!
    var indexValue: Float!
    var dailyReturns: Float!
    var monthlyReturns: Float!
    var yearlyReturns: Float!
    
    
    init(fromJson json: JSON?) {
        super.init()
        guard let json = json else { return }
        scId = json["scid"].stringValue
        name = json["info"]["name"].stringValue
        type = json["info"]["type"].stringValue
        rationale = json["rationale"].stringValue
        indexValue = json["stats"]["indexValue"].floatValue
        dailyReturns = json["stats"]["returns"]["daily"].floatValue
        monthlyReturns = json["stats"]["returns"]["monthly"].floatValue
        yearlyReturns = json["stats"]["returns"]["yearly"].floatValue
        
    }
    

    static func getSmallcase(_ scId: String, completion: @escaping(_ smallcase: Smallcase?, _ error: Error?) -> Void) {
    
        let urlString = baseUrl + "smallcase?scid=" + scId
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        return
                    }
                    do {
                        let json = try JSON(data: data)
                        print(json)
                        let smallCase = Smallcase(fromJson: json["data"])
                        completion(smallCase, nil)
                    } catch (let error){
                        completion(nil, error)
                    }
                case .failure(let error):
                    print(error)
                    completion(nil, error)
                }
        }
    }
}

class ChartData: NSObject {
    var date: Date!
    var index: Double!
    
    init(fromJson json: JSON?) {
        super.init()
        guard let json = json else { return }
        date = Date.getDate(json["date"].stringValue)
        index = json["index"].doubleValue
    }
    
    static func getChartData(_ scId: String, completion: @escaping(_ chartData: [ChartData]?,_ error: Error?) -> Void) {
        let url = histogramUrl + scId
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        return
                    }
                    do {
                        let json = try JSON(data: data)
                        print(json)
                        if let jsonArray = json["data"]["points"].array {
                            var chartData = [ChartData]()
                            for json in jsonArray {
                                let data = ChartData(fromJson: json)
                                chartData.append(data)
                            }
                            completion(chartData, nil)
                        }
                    } catch (let error){
                        completion(nil, error)
                    }
                case .failure(let error):
                    print(error)
                    completion(nil, error)

                }
        }
        
    }
}


