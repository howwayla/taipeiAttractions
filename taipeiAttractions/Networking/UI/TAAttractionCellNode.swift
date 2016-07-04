//
//  TAAttractionCellNode.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/28.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension UIColor {
    
    class func TAAttractionCellTitle() -> UIColor {
        return UIColor(red: 91/255, green: 192/255, blue: 235/255, alpha: 1.0)
    }
}

extension TAAttractionCellNode: CellConfigurable{}

class TAAttractionCellNode: ASCellNode {
    
    var cellController: TAAttractionCellController!
    private let titleNode = ASTextNode()
    private let descriptionNode = ASTextNode()
    private var photoNode: ASNetworkImageNode?
    
    struct TextStyle {
        static let title = [NSFontAttributeName: UIFont.boldSystemFontOfSize(17),
                            NSForegroundColorAttributeName: UIColor.TAAttractionCellTitle()]
        
        static let description = [NSFontAttributeName: UIFont.systemFontOfSize(13),
                                  NSForegroundColorAttributeName: UIColor.darkGrayColor()]
    }
    
    init(cellController: TAAttractionCellController) {
        super.init()
        
        self.cellController = cellController

        setupTitleNode()
        setupDescriptionNode()
        setupPhotoNodeIfNeeded()
    }
    
    private func setupTitleNode() {
        titleNode.attributedString = NSAttributedString(string: cellController.title, attributes: TextStyle.title)
        addSubnode(titleNode)
    }
    
    private func setupDescriptionNode() {
        var attributes = TextStyle.description
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        
        attributes[NSParagraphStyleAttributeName] = paragraphStyle
        descriptionNode.attributedString = NSAttributedString(string: cellController.description, attributes: attributes)
        addSubnode(descriptionNode)
    }
    
    private func setupPhotoNodeIfNeeded() {
        
        if let photoURL = cellController.photoURL {
            photoNode = ASNetworkImageNode()
            photoNode?.URL = photoURL
            photoNode?.shouldCacheImage = true
            addSubnode(photoNode!)
        }
    }
    
    //MARK:- Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        let textLayout = ASStackLayoutSpec(direction: .Vertical,
                                           spacing: 5.0,
                                           justifyContent: .Start,
                                           alignItems: .Start,
                                           children: [titleNode, descriptionNode])

        let textInsetLayout = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(8, 8, 25, 8), child: textLayout)
        
        if let photoNode = photoNode {
            photoNode.preferredFrameSize = CGSizeMake(screenWidth, 300)
            let photoAndTextLayout = ASStackLayoutSpec(direction: .Vertical,
                                                       spacing: 0.0,
                                                       justifyContent: .Start,
                                                       alignItems: .Start,
                                                       children: [photoNode, textInsetLayout])
            return photoAndTextLayout
        } else {
            return textInsetLayout
        }
    }
}
