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
    fileprivate let titleNode = ASTextNode()
    fileprivate let descriptionNode = ASTextNode()
    fileprivate var photoNode: ASNetworkImageNode?
    
    struct TextStyle {
        static let title = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17),
                            NSForegroundColorAttributeName: UIColor.TAAttractionCellTitle()]
        
        static let description = [NSFontAttributeName: UIFont.systemFont(ofSize: 13),
                                  NSForegroundColorAttributeName: UIColor.darkGray]
    }
    
    init(cellController: TAAttractionCellController) {
        super.init()
        
        self.cellController = cellController

        setupTitleNode()
        setupDescriptionNode()
        setupPhotoNodeIfNeeded()
    }
    
    fileprivate func setupTitleNode() {
        titleNode.attributedString = NSAttributedString(string: cellController.title, attributes: TextStyle.title)
        addSubnode(titleNode)
    }
    
    fileprivate func setupDescriptionNode() {
        var attributes = TextStyle.description
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        
        attributes[NSParagraphStyleAttributeName] = paragraphStyle
        descriptionNode.attributedString = NSAttributedString(string: cellController.description, attributes: attributes)
        addSubnode(descriptionNode)
    }
    
    fileprivate func setupPhotoNodeIfNeeded() {
        
        if let photoURL = cellController.photoURL {
            photoNode = ASNetworkImageNode()
            photoNode?.url = photoURL
            photoNode?.shouldCacheImage = true
            addSubnode(photoNode!)
        }
    }
    
    //MARK:- Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let screenWidth = UIScreen.main.bounds.width
        
        let textLayout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 5.0,
                                           justifyContent: .start,
                                           alignItems: .start,
                                           children: [titleNode, descriptionNode])

        let textInsetLayout = ASInsetLayoutSpec(insets: UIEdgeInsetsMake(8, 8, 25, 8), child: textLayout)
        
        if let photoNode = photoNode {
            photoNode.preferredFrameSize = CGSize(width: screenWidth, height: 300)
            let photoAndTextLayout = ASStackLayoutSpec(direction: .vertical,
                                                       spacing: 0.0,
                                                       justifyContent: .start,
                                                       alignItems: .start,
                                                       children: [photoNode, textInsetLayout])
            return photoAndTextLayout
        } else {
            return textInsetLayout
        }
    }
}
