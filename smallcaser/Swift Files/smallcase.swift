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

    

    static func getSmallcase(_ scId: String, completion: @escaping(_ smallcase: Smallcase?, _ error: Error?) -> Void) {
    
        let urlString = baseUrl + "smallcase?scid=" + scId
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    print(response.data!)
                    
                    
                case .failure(let error):
                    print(error)
                    
                    if let cachedResponse = cache.object(forKey: urlString) {
                        
                    }
                }
        }
    }

}


