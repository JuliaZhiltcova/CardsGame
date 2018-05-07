//
//  StrokedTextButton.swift
//  Cards
//
//  Created by Admin on 12/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class StrokedTextButton: UIButton {

        func setCustomAttributedTitle(title: String, fontSize: CGFloat){
            let strokeTextAttributes = [
                NSStrokeColorAttributeName : UIColor.black,
                NSForegroundColorAttributeName : UIColor.white,
                NSStrokeWidthAttributeName : -4.0,
                NSFontAttributeName: UIFont(name: "EjaRoundFilled", size: fontSize)!
                ] as [String : Any]
            let attributedString = NSAttributedString(string: title, attributes: strokeTextAttributes)
            self.setAttributedTitle(attributedString, for: .normal)
        }
    
}
