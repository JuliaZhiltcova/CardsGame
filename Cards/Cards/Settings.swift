//
//  Tune.swift
//  Cards
//
//  Created by Admin on 31/01/2018.
//  Copyright © 2018 Admin. All rights reserved.
//


import UIKit

class Settings {
    
    
    static let cardEdge: CGFloat = 60.0
    static let interItemInset: CGFloat = 10.0
    static let stage = 4
    
    static let ElementsPerRowAndColumn = [
        [4, 2, 2],
        [6, 3, 2],
        [8, 3, 3],
        [10, 4, 3],
        [12, 4, 3],
        [14, 4, 4],
        [16, 4, 4]]
    
    static var widthConstant: CGFloat {
        return CGFloat(ElementsPerRowAndColumn[stage - 1][1])*(cardEdge + interItemInset)
    }
        
 
    static var heightConstant: CGFloat {
        return CGFloat(ElementsPerRowAndColumn[stage - 1][2]) * ( cardEdge + interItemInset)
    }

}
