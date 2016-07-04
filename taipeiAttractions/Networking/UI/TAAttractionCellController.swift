//
//  TAAttractionCellController.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/7/5.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import Foundation

protocol TAAttractionCellRepresentable {
    
    var title: String { get }
    var description: String { get }
    var photoURL: NSURL? { get }
}

class TAAttractionCellController: TAAttractionCellRepresentable {
    
    let title: String
    let description: String
    let photoURL: NSURL?
    
    init(attraction: TAAttraction) {
        title = attraction.title ?? ""
        description = attraction.description ?? ""
        photoURL = attraction.photoURL?.first
    }
}