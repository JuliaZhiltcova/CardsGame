//
//  CenterAlignedCollectionViewFlowLayout.swift
//  Cards
//
//  Created by Admin on 30/01/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CenterAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
  

    let interItemInset: CGFloat = 10.0
    //var level: Int!
    
    var boundWidth: CGFloat = 0
    var boundHeight: CGFloat = 0
    
    var level = LevelsManager.currentLevel!.number
    var cardEdge: CGFloat{
        return (boundHeight - interItemInset * CGFloat(GameSettings.ElementsPerRowAndColumn[level - 1][2] + 1) - CGFloat(boundHeight/4)) / CGFloat(GameSettings.ElementsPerRowAndColumn[level - 1][2])
    }
    
    
    var widthConstant: CGFloat {
        return CGFloat(GameSettings.ElementsPerRowAndColumn[level - 1][1])*(cardEdge + interItemInset)
    }
    
    
    var heightConstant: CGFloat {
        return CGFloat(GameSettings.ElementsPerRowAndColumn[level - 1][2]) * ( cardEdge + interItemInset)
    }
    
    lazy var isFull: Bool =  GameSettings.ElementsPerRowAndColumn[self.level - 1][1] *
                             GameSettings.ElementsPerRowAndColumn[self.level - 1][2]  -
                             GameSettings.ElementsPerRowAndColumn[self.level - 1][0] == 0
    
    override func prepare() {
        
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        var xOffset: CGFloat = interItemInset
        var yOffset: CGFloat = interItemInset
        var row = 1
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) + 0 {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let frame = CGRect(x: xOffset, y: yOffset, width: cardEdge, height: cardEdge)
            let insetFrame = frame.insetBy(dx: 0, dy: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            if ((item + 1) % GameSettings.ElementsPerRowAndColumn[level - 1][1]) != 0 {
                xOffset = xOffset + cardEdge + interItemInset
            } else {
                xOffset = interItemInset
                yOffset = yOffset + cardEdge + interItemInset
                row = row + 1
                if !isFull && row == GameSettings.ElementsPerRowAndColumn[level - 1][2]{
                    let numberOfCardsInLastRow = GameSettings.ElementsPerRowAndColumn[level - 1][1] -
                        (GameSettings.ElementsPerRowAndColumn[level - 1][1] * GameSettings.ElementsPerRowAndColumn[level - 1][2] - GameSettings.ElementsPerRowAndColumn[level - 1][0])
                    
                    let additionalSpace: CGFloat = (
                        //length of full row
                        (CGFloat(GameSettings.ElementsPerRowAndColumn[level - 1][1]) * CGFloat(cardEdge) +
                            CGFloat(GameSettings.ElementsPerRowAndColumn[level - 1][1] - 1) * CGFloat(interItemInset)) -
                            //length of unfull row
                            (CGFloat(numberOfCardsInLastRow) * CGFloat(cardEdge) + CGFloat(numberOfCardsInLastRow - 1) * interItemInset)
                        
                        ) / 2
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


//        let leftPadding: CGFloat = 8
//        let interItemSpacing = minimumInteritemSpacing
//
//        // Tracking values
//        var leftMargin: CGFloat = leftPadding // Modified to determine origin.x for each item
//        var maxY: CGFloat = -1.0 // Modified to determine origin.y for each item
//        var rowSizes: [[CGFloat]] = [] // Tracks the starting and ending x-values for the first and last item in the row
//        var currentRow: Int = 0 // Tracks the current row
//
//        cache.forEach { layoutAttribute in
//
//            // Each layoutAttribute represents its own item
//            if layoutAttribute.frame.origin.y >= maxY {
//
//                // This layoutAttribute represents the left-most item in the row
//                leftMargin = leftPadding
//
//                // Register its origin.x in rowSizes for use later
//                if rowSizes.count == 0 {
//                    // Add to first row
//                    rowSizes = [[leftMargin, 0]]
//                } else {
//                    // Append a new row
//                    rowSizes.append([leftMargin, 0])
//                    currentRow += 1
//                }
//            }
//
//            layoutAttribute.frame.origin.x = leftMargin
//
//            leftMargin += layoutAttribute.frame.width + interItemSpacing
//            maxY = max(layoutAttribute.frame.maxY, maxY)
//
//            // Add right-most x value for last item in the row
//            rowSizes[currentRow][1] = leftMargin - interItemSpacing
//        }
//
//        leftMargin = leftPadding
//        maxY = -1.0
//        currentRow = 0
//        cache.forEach { layoutAttribute in
//
//            // Each layoutAttribute is its own item
//            if layoutAttribute.frame.origin.y >= maxY {
//
//                // This layoutAttribute represents the left-most item in the row
//                leftMargin = leftPadding
//
//                // Need to bump it up by an appended margin
//                let rowWidth = rowSizes[currentRow][1] - rowSizes[currentRow][0] // last.x - first.x
//                let appendedMargin = (widthConstant - leftPadding  - rowWidth - leftPadding) / 2
//                leftMargin += appendedMargin
//
//                currentRow += 1
//            }
//            layoutAttribute.frame.origin.x = leftMargin
//
//            leftMargin += layoutAttribute.frame.width + interItemSpacing
//            maxY = max(layoutAttribute.frame.maxY, maxY)
//        }
//    }


/*
override func prepare() {
    
    guard cache.isEmpty == true, let collectionView = collectionView else {
        return
    }
    
    var xOffset: CGFloat = interItemInset
    var yOffset: CGFloat = interItemInset
    var row = 1
    
    for item in 0 ..< collectionView.numberOfItems(inSection: 0) + 0 {
        
        let indexPath = IndexPath(item: item, section: 0)
        
        let frame = CGRect(x: xOffset, y: yOffset, width: cardEdge, height: cardEdge)
        let insetFrame = frame.insetBy(dx: 0, dy: 0)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
        
        if ((item + 1) % GameSettings.ElementsPerRowAndColumn[level - 1][1]) != 0 {
            xOffset = xOffset + cardEdge + interItemInset
        } else {
            xOffset = interItemInset
            yOffset = yOffset + cardEdge + interItemInset
            row = row + 1
            if !isFull && row == GameSettings.ElementsPerRowAndColumn[level - 1][2]{
                let numberOfCardsInLastRow = GameSettings.ElementsPerRowAndColumn[level - 1][1] -
                    (GameSettings.ElementsPerRowAndColumn[level - 1][1] * GameSettings.ElementsPerRowAndColumn[level - 1][2] - GameSettings.ElementsPerRowAndColumn[level - 1][0])
                
                let additionalSpace: CGFloat = (
                    //length of full row
                    (CGFloat(GameSettings.ElementsPerRowAndColumn[level - 1][1]) * CGFloat(cardEdge) +
                        CGFloat(GameSettings.ElementsPerRowAndColumn[level - 1][1] - 1) * CGFloat(interItemInset)) -
                        //length of unfull row
                        (CGFloat(numberOfCardsInLastRow) * CGFloat(cardEdge) + CGFloat(numberOfCardsInLastRow - 1) * interItemInset)
                    
                    ) / 2
                xOffset = xOffset + additionalSpace
            }
        }
    }
    // print(cache)
}
*/
