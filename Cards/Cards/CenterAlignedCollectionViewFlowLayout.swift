//
//  CenterAlignedCollectionViewFlowLayout.swift
//  Cards
//
//  Created by Admin on 30/01/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CenterAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    //let interItemInset: CGFloat = 10.0
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    //let cardEdge: CGFloat = 60.0
    let stage = 4
    
    lazy var isFull: Bool = ( Settings.ElementsPerRowAndColumn[self.stage - 1][1] *
                              Settings.ElementsPerRowAndColumn[self.stage - 1][2]  -
                              Settings.ElementsPerRowAndColumn[self.stage - 1][0] == 0) ? true : false
    
    override func prepare() {
    
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }

        var xOffset: CGFloat = Settings.interItemInset
        var yOffset: CGFloat = Settings.interItemInset
        var row = 1
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) + 0 {
        
            let indexPath = IndexPath(item: item, section: 0)
           print (Settings.boundHeight)
            print (Settings.boundWidth)
            print(Settings.cardEdge)
            let frame = CGRect(x: xOffset, y: yOffset, width: Settings.cardEdge, height: Settings.cardEdge)
            let insetFrame = frame.insetBy(dx: 0, dy: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            if ((item + 1) % Settings.ElementsPerRowAndColumn[stage - 1][1]) != 0 {
                xOffset = xOffset + Settings.cardEdge + Settings.interItemInset
            } else {
                xOffset = Settings.interItemInset
                yOffset = yOffset + Settings.cardEdge + Settings.interItemInset
                row = row + 1
                if !isFull && row == Settings.ElementsPerRowAndColumn[stage - 1][2]{
                    let additionalSpace: CGFloat = (
                        CGFloat(Settings.ElementsPerRowAndColumn[stage - 1][1]) * CGFloat(Settings.cardEdge) +
                            CGFloat(Settings.ElementsPerRowAndColumn[stage - 1][1] - 1) * CGFloat(Settings.interItemInset) -
                            (CGFloat(2) * CGFloat(Settings.cardEdge) + CGFloat(Settings.interItemInset))) / 2
                    xOffset = xOffset + additionalSpace
                }
            }
        }
        // print(cache)
        }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}
