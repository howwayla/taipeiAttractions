//
//  TAAttraction.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/27.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import Foundation
import ObjectMapper


struct TAAttraction: Mappable {

    var ID: String?
    var category: String?
    var title: String?
    var description: String?
    var photoURL: [NSURL]?
    
    
    init(JSON: JSONDictionary) {
        if let object = Mapper<TAAttraction>().map(JSON) {
            self = object
        }
    }
    
    //MARK:- Mappable
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        ID          <- map["_id"]
        category    <- map["CAT2"]
        title       <- map["stitle"]
        description <- map["xbody"]
        photoURL    <- (map["file"], PhotoURLTransform())
    }
}