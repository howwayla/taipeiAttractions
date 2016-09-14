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
    
    typealias Object = [URL]
    typealias JSON = String?
    
    
    public func transformFromJSON(_ value: Any?) -> PhotoURLTransform.Object? {
        if let value = value as? String {
            let imageURLs = parseImageURLWithDataString(value)
            return imageURLs
        }
        
        return nil
    }
    
    func transformToJSON(_ value: PhotoURLTransform.Object?) -> PhotoURLTransform.JSON? {
        if let imageURLs = value {
            return imageURLs.map{ $0.absoluteString }.joined(separator: "")
        }
        return nil
    }
}

//MARK:- Paring methods
extension PhotoURLTransform {

    fileprivate func parseImageURLWithDataString(_ date: String) -> [URL] {
        var dateString = date
        var imageURL: [URL] = []
        
        while let range = dateString.range(of: "http", options: [.caseInsensitive], range: dateString.characters.index(dateString.startIndex, offsetBy: 1) ..< dateString.endIndex, locale: nil) {
            
            let subString = dateString.substring(with: dateString.startIndex ..< range.lowerBound)
            if isImageURLString(subString) {
                imageURL.append(URL(string: subString)!)
            }
            
            dateString.removeSubrange(date.startIndex ..< subString.endIndex)
        }
        
        if dateString.contains("http") && isImageURLString(dateString) {
            imageURL.append(URL(string: dateString)!)
        }
        
        return imageURL
    }
    
    
    fileprivate func isImageURLString(_ imageURLString: String) -> Bool {
        if imageURLString.range(of: ".jpg", options: [.caseInsensitive], range: nil, locale: nil) != nil {
            return true
        }
        
        if imageURLString.range(of: ".png", options: [.caseInsensitive], range: nil, locale: nil) != nil {
            return true
        }
        
        return false
    }
}
