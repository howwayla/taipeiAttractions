//
//  LocationTransform.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/7/1.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation

class LocationTransform: TransformType {
    
    typealias Object = CLLocation
    typealias JSON = JSONDictionary
    
    func transformFromJSON(value: AnyObject?) -> LocationTransform.Object? {
        guard let value = value as? JSONDictionary else {
            return nil
        }
        
        let longitude: CLLocationDegrees = CLLocationDegrees(value["longitude"] as! String)!
        let latitude: CLLocationDegrees = CLLocationDegrees(value["latitude"] as! String)!
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func transformToJSON(value: LocationTransform.Object?) -> LocationTransform.JSON? {
        guard let location = value else {
            return nil
        }
        
        return ["longitude" : "\(location.coordinate.longitude)",
                "latitude"  : "\(location.coordinate.latitude)"]
    }
}