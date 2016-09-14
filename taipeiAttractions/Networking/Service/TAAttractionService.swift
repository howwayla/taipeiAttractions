//
//  TAAttractionService.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/27.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import Foundation
import Alamofire

class TAAttractionService {
    /**
     Get Taipei attractions

     - parameter completionHandler: A block to execute after complete fetch attractions
     */
    class func getAttractions(_ completionHandler: @escaping (Result<[TAAttraction]>) -> Void) {
        
        let URLRequest = TAAttractionRouter.attractions
        
        Alamofire.request(URLRequest)
            .validate()
            .responseJSON() { response in
                
                switch response.result {
                case .success(let JSON):
                    var attractions: [TAAttraction] = []
                    
                    let JSON = JSON as! JSONDictionary
                    let result = JSON["result"] as! JSONDictionary
                    let attractionJSON = result["results"] as? [JSONDictionary] ?? []
                    for item in attractionJSON {
                        attractions.append(TAAttraction(JSON: item))
                    }
                    
                    //Set attractions in data service instance
                    TAAppDataService.sharedInstance.attractions = attractions
                    
                    completionHandler(Result.success(attractions))
                    
                case .failure(let error):
                    debugPrint(error)
                    completionHandler(Result.failure(error))
                }
        }
    }
}
