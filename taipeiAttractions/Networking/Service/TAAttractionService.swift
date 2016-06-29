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
    class func getAttractions(completionHandler: (Result<[TAAttraction], NSError>) -> Void) {
        
        let URLRequest = TAAttractionRouter.Attractions
        
        Alamofire.request(URLRequest)
            .validate()
            .responseJSON() { response in
                
                switch response.result {
                case .Success(let JSON):
                    var attractions: [TAAttraction] = []
                    
                    let result = JSON["result"] as! JSONDictionary
                    let attractionJSON = result["results"] as? [JSONDictionary] ?? []
                    for item in attractionJSON {
                        attractions.append(TAAttraction(JSON: item))
                    }
                    
                    //Set attractions in data service instance
                    TAAppDataService.sharedInstance.attractions = attractions
                    
                    completionHandler(Result.Success(attractions))
                    
                case .Failure(let error):
                    debugPrint(error)
                    completionHandler(Result.Failure(error))
                }
        }
    }
}