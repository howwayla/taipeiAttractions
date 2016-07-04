//
//  CellConfigurable.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/7/5.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import Foundation

protocol CellConfigurable: class{
    
    associatedtype Controller
    var cellController: Controller! { get set }
}