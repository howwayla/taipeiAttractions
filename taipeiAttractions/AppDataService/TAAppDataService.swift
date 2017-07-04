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
    fileprivate init() {}
    
    var categories: [String] = []
    
    var attractions: [TAAttraction] = [] {
        didSet {
            setupCategories()
            setupAttractionsByCategory()
        }
    }
    
    var attractionsByCategory: [String: [TAAttraction]] = [:]
    
    
    //MARK:- Setup methods
    /**
     Setup categories from attractions
     */
    fileprivate func setupCategories() {
        
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
    
    fileprivate func setupAttractionsByCategory() {
        for category in self.categories {
            let attractions = self.attractions.filter{ $0.category == category }
            self.attractionsByCategory[category] = attractions
        }
    }
}
