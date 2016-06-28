//
//  PhotoURLTransform.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/28.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import Foundation
import ObjectMapper

/// Transform TAAttraction JSON file column from string to image URL array
class PhotoURLTransform: TransformType {
    
    typealias Object = [NSURL]
    typealias JSON = String?
    
    
    func transformFromJSON(value: AnyObject?) -> PhotoURLTransform.Object? {
        if let value = value as? String {
            let imageURLs = parseImageURLWithDataString(value)
            return imageURLs
        }
        
        return nil
    }
    
    func transformToJSON(value: PhotoURLTransform.Object?) -> PhotoURLTransform.JSON? {
        if let imageURLs = value {
            return imageURLs.map{ $0.absoluteString }.joinWithSeparator("")
        }
        return nil
    }
}

//MARK:- Paring methods
extension PhotoURLTransform {

    private func parseImageURLWithDataString(date: String) -> [NSURL] {
        var dateString = date
        var imageURL: [NSURL] = []
        
        while let range = dateString.rangeOfString("http", options: [.CaseInsensitiveSearch], range: dateString.startIndex.advancedBy(1) ..< dateString.endIndex, locale: nil) {
            
            let subString = dateString.substringWithRange(dateString.startIndex ..< range.startIndex)
            if isImageURLString(subString) {
                imageURL.append(NSURL(string: subString)!)
            }
            
            dateString.removeRange(date.startIndex ..< subString.endIndex)
        }
        
        if dateString.containsString("http") && isImageURLString(dateString) {
            imageURL.append(NSURL(string: dateString)!)
        }
        
        return imageURL
    }
    
    
    private func isImageURLString(imageURLString: String) -> Bool {
        if imageURLString.rangeOfString(".jpg", options: [.CaseInsensitiveSearch], range: nil, locale: nil) != nil {
            return true
        }
        
        if imageURLString.rangeOfString(".png", options: [.CaseInsensitiveSearch], range: nil, locale: nil) != nil {
            return true
        }
        
        return false
    }
}