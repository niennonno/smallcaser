//
//  Constants.swift
//  smallcaser
//
//  Created by Aditya Vikram Godawat on 22/06/18.
//  Copyright © 2018 Aditya Vikram Godawat. All rights reserved.
//

import Foundation

let smallcaseIds = ["SCMO_0002", "SCMO_0003", "SCMO_0006", "SCNM_0003", "SCNM_0007", "SCNM_0008", "SCNM_0009"]

let baseUrl = "https://api-dev.smallcase.com/smallcases/"

let imageUrl = "https://www.smallcase.com/images/smallcases/187/"

let histogramUrl = "https://api-dev.smallcase.com/smallcases/historical?scid="

//let cache = URLCache().getCachedResponse(for: <#T##URLSessionDataTask#>, completionHandler: <#T##(CachedURLResponse?) -> Void#>)

extension Date {
    static func getDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"         //2014-06-26T00:00:00.000Z
        let dateObj = dateFormatter.date(from: string)
        return dateObj ?? Date()
    }
}
