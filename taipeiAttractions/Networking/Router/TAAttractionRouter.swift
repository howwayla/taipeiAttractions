//
//  TAAttractionRouter.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/27.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String : AnyObject]

enum TAAttractionRouter: URLRequestConvertible {
    
    /// Get attractions
    case Attractions
    
    
    var path: String {
        switch self {
        case .Attractions:
            return "/opendata/datalist/apiAccess"
        }
    }
    
    var parameters: JSONDictionary? {
        switch self {
        case .Attractions:
            return ["scope": "resourceAquire", "rid": "36847f3f-deff-4183-a5bb-800737591de5"]
        }
    }
    
    
    //MARK:- NSMutableURLRequest methods
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: TANetworkingConfig.baseURLString)!
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(self.path))
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: self.parameters).0
    }
}