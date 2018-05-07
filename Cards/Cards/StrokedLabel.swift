//
//  StrokedLabel.swift
//  Cards
//
//  Created by Admin on 12/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class StrokedLabel: UILabel {
    
    
    var strockedText: String = "" {
        willSet(newValue) {
            let strokeTextAttributes = [
                NSStrokeColorAttributeName : UIColor.black,
                NSForegroundColorAttributeName : UIColor.white,
                NSStrokeWidthAttributeName : -4.0
                ] as [String : Any]
            
            let customizedText = NSMutableAttributedString(string: newValue,
                                                           attributes: strokeTextAttributes)
            
            
            attributedText = customizedText
        }
    }
}
