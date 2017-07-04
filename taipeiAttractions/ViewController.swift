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
            reloadButton.layer.borderColor = UIColor.lightGray.cgColor
            reloadButton.layer.borderWidth = 1.0
            reloadButton.layer.cornerRadius = 5.0
        }
    }
    fileprivate var tableView: ASTableView!
    
    
    fileprivate var attractions: [String : [TAAttractionCellController]] = [:]
    fileprivate var selectedCategory: String? {
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
    fileprivate func setupTableView() {
        tableView = ASTableView(frame: CGRect.zero)
        tableView.asyncDataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
    }
    
    fileprivate func setTableViewFrame() {
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    fileprivate func setupNavigation() {
        title = "全部"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter-icon"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showFilterActionSheet))
    }
}


//MARK:- Actions
extension ViewController {
    fileprivate func fetchAttractions() {
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        
        TAAttractionService.getAttractions(){ result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.fetchAttractionsDidSuccess()
                case .failure(_):
                    self.fetchAttractionsDidFail()
                }
            }
        }
    }
    
    fileprivate func fetchAttractionsDidSuccess() {
        SVProgressHUD.dismiss()
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        reloadButton.isHidden = true
        self.tableView.isHidden = false
        
        //Set data and reload table view
        self.transformToAttractionCellControllers()
        tableView.reloadData()
    }
    
    fileprivate func transformToAttractionCellControllers() {
        for  key in TAAppDataService.sharedInstance.attractionsByCategory.keys {
            guard let attractions = TAAppDataService.sharedInstance.attractionsByCategory[key] else {
                continue
            }
            self.attractions[key] = attractions.map(TAAttractionCellController.init)
        }
    }
    
    fileprivate func fetchAttractionsDidFail() {
        SVProgressHUD.showError(withStatus: "載入失敗")
        SVProgressHUD.dismiss(withDelay: 0.8)
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        reloadButton.isHidden = false
        tableView.isHidden = true
    }
    
    
    @objc fileprivate func showFilterActionSheet() {
        let actionSheet = UIAlertController(title: "選擇類別", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "全部", style: .default) { _ in
            self.selectedCategory = nil
        })
        
        for category in TAAppDataService.sharedInstance.categories {
            actionSheet.addAction(UIAlertAction(title: category, style: .default) { _ in
                self.selectedCategory = category
            })
        }
        actionSheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func reloadData(_ sender: UIButton) {
        fetchAttractions()
    }
}


//MARK:- ASTableViewDataSource
extension ViewController: ASTableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return attractions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categoryString(section)
        return attractions[category]?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // hide section header if user selected one category
        if selectedCategory != nil {
            return nil
        }
        
        return TAAppDataService.sharedInstance.categories[section]
    }
    
    func tableView(_ tableView: ASTableView, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let category = categoryString(indexPath.section)
        let attraction = attractions[category]![indexPath.row]
        let cellNdoe = TAAttractionCellNode(cellController: attraction)
        
        return cellNdoe
    }
    
    fileprivate func categoryString(_ section: Int) -> String {
        var category: String!
        if selectedCategory != nil {
            category = selectedCategory
        } else {
            category = TAAppDataService.sharedInstance.categories[section]
        }
        return category
    }
}
