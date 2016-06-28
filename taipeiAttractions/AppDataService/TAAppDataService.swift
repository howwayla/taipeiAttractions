//
//  TAAppDataService.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/28.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import Foundation

class TAAppDataService {
    
    static let sharedInstance = TAAppDataService()
    private init() {}
    
    var categories: [String] = []
    
    var attractions: [TAAttraction] = [] {
        didSet {
           setupCategories()
        }
    }
    
    //MARK:- Setup methods
    /**
     Setup categories from attractions
     */
    private func setupCategories() {
        
        var newCategories: [String] = []
        for category in (attractions.map{ $0.category }) {
            
            guard let category = category else {
                continue
            }
            
            if !newCategories.contains(category) {
                newCategories.append(category)
            }
        }
        self.categories = newCategories
    }
}