//
//  DesignableView.swift
//  Cards
//
//  Created by Admin on 20/02/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
