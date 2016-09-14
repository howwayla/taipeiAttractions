//
//  TAAttractionRouter.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/27.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String : Any]

enum TAAttractionRouter: URLRequestConvertible {
    
    /// Get attractions
    case attractions
    
    
    var path: String {
        switch self {
        case .attractions:
            return "/opendata/datalist/apiAccess"
        }
    }
    
    var parameters: JSONDictionary? {
        switch self {
        case .attractions:
            return ["scope": "resourceAquire" as AnyObject, "rid": "36847f3f-deff-4183-a5bb-800737591de5" as AnyObject]
        }
    }
    
    
    //MARK:- NSMutableURLRequest methods
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    public func asURLRequest() throws -> URLRequest {
        let URL = Foundation.URL(string: TANetworkingConfig.baseURLString)!
        let URLRequest = Foundation.URLRequest(url: URL.appendingPathComponent(self.path))
        
        return try URLEncoding.default.encode(URLRequest, with: self.parameters)
    }
}
