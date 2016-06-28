//
//  ViewController.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/27.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import UIKit
import SVProgressHUD
import AsyncDisplayKit


class ViewController: UIViewController {

    private var attractions: [String : [TAAttraction]] = [:]
    
    private var tableView: ASTableView!
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchAttractions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTableViewFrame()
    }
    
    //MArk:- Setup methods
    private func setupTableView() {
        tableView = ASTableView(frame: CGRectZero)
        tableView.asyncDataSource = self
        tableView.separatorStyle = .None
        
        self.view.addSubview(tableView)
    }
    
    private func setTableViewFrame() {
        tableView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
    }
    
    
    //MARK:- Actions
    private func fetchAttractions() {
        SVProgressHUD.show()
        TAAttractionService.getAttractions(){ result in
            dispatch_async(dispatch_get_main_queue()) {
                SVProgressHUD.dismiss()
                switch result {
                case .Success(_):
                    self.fetchAttractionsDidSuccess()
                case .Failure(_):
                    break
                }
            }
        }
    }
    
    private func fetchAttractionsDidSuccess() {
        
        for category in TAAppDataService.sharedInstance.categories {
            let attractions = TAAppDataService.sharedInstance.attractions.filter{ $0.category == category }
            self.attractions[category] = attractions
        }
        
        self.tableView.reloadData()
    }
}

extension ViewController: ASTableViewDataSource {
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TAAppDataService.sharedInstance.categories[section]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TAAppDataService.sharedInstance.categories.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = TAAppDataService.sharedInstance.categories[section]
        return attractions[category]?.count ?? 0
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let category = TAAppDataService.sharedInstance.categories[indexPath.section]
        let attraction = attractions[category]![indexPath.row]
        
        let cellNdoe = TAAttractionCellNode(attraction: attraction)
        
        return cellNdoe
    }
}