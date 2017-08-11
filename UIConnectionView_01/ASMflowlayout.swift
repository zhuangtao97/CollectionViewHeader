//
//  ASMflowlayout.swift
//  UIConnectionView_01
//
//  Created by zhuangtao on 2017/8/10.
//  Copyright © 2017年 zhuangtao. All rights reserved.
//

import Foundation

import UIKit

class ASMflowlayout: UICollectionViewFlowLayout {

    
    override init() {
        super.init()
    }
    
    required  init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var answer = super.layoutAttributesForElements(in: rect)
        let cv = self.collectionView
        let contentOffset = cv?.contentOffset
        var missingSectons = IndexSet.init()
        
        for layoutAttributes in answer! {
            
            if layoutAttributes.representedElementCategory == .cell{
                
                missingSectons.insert(layoutAttributes.indexPath.section)
                
            }
        }
        
        for layoutAttributes in answer! {
            
            if layoutAttributes.representedElementKind == UICollectionElementKindSectionHeader{
                
                missingSectons .remove(layoutAttributes.indexPath.section)
                
            }
        }
        
        for (index,_) in missingSectons.enumerated(){
            
            let indexpath = IndexPath.init(row: 0, section: index)
            let layoutAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexpath)
    
            answer?.append(layoutAttributes!)
            
        }
        
        for layoutAttributes in answer! {
            
            if layoutAttributes.representedElementKind == UICollectionElementKindSectionHeader{
                
                let section = layoutAttributes.indexPath.section
                let numberOfItemsInSection = cv?.numberOfItems(inSection: section)
                
                let firstCellIndexPath = IndexPath.init(row: 0, section: section)
                let lastCellIndexPath = IndexPath.init(row: max(0,(numberOfItemsInSection! - 1)), section: section)
                
                let firstCellAttrs = self.layoutAttributesForItem(at: firstCellIndexPath)
                let lastCellAttrs = self.layoutAttributesForItem(at: lastCellIndexPath)
                
                if self.scrollDirection == UICollectionViewScrollDirection.vertical{
                    
                    let headerHeight = layoutAttributes.frame.size.height
                    var origin = layoutAttributes.frame.origin
                    origin.y = min(max((contentOffset?.y)!, (firstCellAttrs?.frame.minY)! - headerHeight), (lastCellAttrs?.frame.maxY)! - headerHeight)
                    
                    layoutAttributes.zIndex = 1024
                    layoutAttributes.frame = CGRect.init(origin: origin, size: layoutAttributes.frame.size)
                    
                } else {
                    
                    let headerWidth = layoutAttributes.frame.width
                    var origin = layoutAttributes.frame.origin
                    
                    origin.x = min(max((contentOffset?.x)!, (firstCellAttrs?.frame.minX)! - headerWidth), (lastCellAttrs?.frame.maxX)! - headerWidth)
                    layoutAttributes.zIndex = 1024
                    layoutAttributes.frame = CGRect.init(origin: origin, size: layoutAttributes.frame.size)
                }
            }
        }
        return answer
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
