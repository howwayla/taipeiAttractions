//
//  TAAttraction.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/27.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation

struct TAAttraction: Mappable {

    var ID: String?
    var category: String?
    var title: String?
    var location: CLLocation?
    var description: String?
    var photoURL: [NSURL]?
    
    
    init(JSON: JSONDictionary) {
        
        let restructJSON = restructLocation(JSON: JSON)

        if let object = Mapper<TAAttraction>().map(restructJSON) {
            self = object
        }
    }
    
    private func restructLocation(JSON JSON: JSONDictionary) -> JSONDictionary {
        var restructJSON = JSON
        guard restructJSON["location"] == nil else {
            return JSON
        }
        
        guard let longitude = JSON["longitude"] as? String,
              let latitude = JSON["latitude"]  as? String else {
            return JSON
        }
        
        restructJSON["location"] = [ "longitude" : longitude,
                                     "latitude"  : latitude ]
        return restructJSON
    }
    
    
    //MARK:- Mappable
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        ID          <- map["_id"]
        category    <- map["CAT2"]
        title       <- map["stitle"]
        location    <- (map["location"], LocationTransform())
        description <- map["xbody"]
        photoURL    <- (map["file"], PhotoURLTransform())
    }
}