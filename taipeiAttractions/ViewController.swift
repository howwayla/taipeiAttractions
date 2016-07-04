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

    @IBOutlet weak var reloadButton: UIButton! {
        didSet {
            reloadButton.layer.borderColor = UIColor.lightGrayColor().CGColor
            reloadButton.layer.borderWidth = 1.0
            reloadButton.layer.cornerRadius = 5.0
        }
    }
    private var tableView: ASTableView!
    
    
    private var attractions: [String : [TAAttractionCellController]] = [:]
    private var selectedCategory: String? {
        didSet {
            attractions.removeAll()
            if let selectedCategory = selectedCategory {
                title = selectedCategory
                
                attractions[selectedCategory] = TAAppDataService.sharedInstance.attractionsByCategory[selectedCategory]!.map(TAAttractionCellController.init)
                
            } else {
                title = "全部"
                self.transformToAttractionCellControllers()
            }
            tableView.reloadData()
        }
    }
    
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchAttractions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTableViewFrame()
        setupNavigation()
    }
    
    //MArk:- Setup methods
    private func setupTableView() {
        tableView = ASTableView(frame: CGRectZero)
        tableView.asyncDataSource = self
        tableView.separatorStyle = .None
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
    }
    
    private func setTableViewFrame() {
        tableView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
    }
    
    private func setupNavigation() {
        title = "全部"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter-icon"),
                                                            style: .Plain,
                                                            target: self,
                                                            action: #selector(showFilterActionSheet))
    }
}


//MARK:- Actions
extension ViewController {
    private func fetchAttractions() {
        
        SVProgressHUD.setDefaultMaskType(.Clear)
        SVProgressHUD.show()
        
        TAAttractionService.getAttractions(){ result in
            dispatch_async(dispatch_get_main_queue()) {
                switch result {
                case .Success(_):
                    self.fetchAttractionsDidSuccess()
                case .Failure(_):
                    self.fetchAttractionsDidFail()
                }
            }
        }
    }
    
    private func fetchAttractionsDidSuccess() {
        SVProgressHUD.dismiss()
        
        navigationItem.rightBarButtonItem?.enabled = true
        reloadButton.hidden = true
        self.tableView.hidden = false
        
        //Set data and reload table view
        self.transformToAttractionCellControllers()
        tableView.reloadData()
    }
    
    private func transformToAttractionCellControllers() {
        for  key in TAAppDataService.sharedInstance.attractionsByCategory.keys {
            guard let attractions = TAAppDataService.sharedInstance.attractionsByCategory[key] else {
                continue
            }
            self.attractions[key] = attractions.map(TAAttractionCellController.init)
        }
    }
    
    private func fetchAttractionsDidFail() {
        SVProgressHUD.showErrorWithStatus("載入失敗")
        SVProgressHUD.dismissWithDelay(0.8)
        
        navigationItem.rightBarButtonItem?.enabled = false
        reloadButton.hidden = false
        tableView.hidden = true
    }
    
    
    @objc private func showFilterActionSheet() {
        let actionSheet = UIAlertController(title: "選擇類別", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "全部", style: .Default) { _ in
            self.selectedCategory = nil
        })
        
        for category in TAAppDataService.sharedInstance.categories {
            actionSheet.addAction(UIAlertAction(title: category, style: .Default) { _ in
                self.selectedCategory = category
            })
        }
        actionSheet.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func reloadData(sender: UIButton) {
        fetchAttractions()
    }
}


//MARK:- ASTableViewDataSource
extension ViewController: ASTableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return attractions.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categoryString(section)
        return attractions[category]?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // hide section header if user selected one category
        if selectedCategory != nil {
            return nil
        }
        
        return TAAppDataService.sharedInstance.categories[section]
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let category = categoryString(indexPath.section)
        let attraction = attractions[category]![indexPath.row]
        let cellNdoe = TAAttractionCellNode(cellController: attraction)
        
        return cellNdoe
    }
    
    
    private func categoryString(section: Int) -> String {
        var category: String!
        if selectedCategory != nil {
            category = selectedCategory
        } else {
            category = TAAppDataService.sharedInstance.categories[section]
        }
        return category
    }
}