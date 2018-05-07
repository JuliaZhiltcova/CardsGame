//
//  Phantom.swift
//  Cards
//
//  Created by Admin on 06/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//



/*
 Since we are creating the UIButton’s appearance in code, we want to make sure that the button loads its appearance code before the view appears to the user. In other words, we don’t want to see the standard Xcode button appear and then build itself while we watch, right? So, there are two possible functions we can use for our code: initWithCoder or awakeFromNib. The main difference between the two is that awakeFromNib is only run after all the connections to the nib have been loaded. I personally prefer to use awakeFromNib.
 */

import UIKit

class PhantomButton: UIButton {
    
    required init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = self.frame.height / 2
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor //UIColor(red: 231.0/255.0, green: 60.0/255.0, blue: 60.0/255.0, alpha: 1.0).cgColor
        clipsToBounds = true
        
    }
    
 /*   override func awakeFromNib() {
        super.awakeFromNib()
        
        let color = UIColor.red
        let disabledColor = color.withAlphaComponent(0.3)
        let gradientColor1 = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 1).cgColor
        let gradientColor2 = UIColor(red: 50.0 / 255.0, green: 50.0 / 255.0, blue: 50.0 / 255.0, alpha: 1).cgColor
        
        let btnFont = "Noteworthy"

        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        
        self.layer.borderColor = color.cgColor
        
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(disabledColor, for: .disabled)
        self.titleLabel?.font = UIFont(name: btnFont, size: 25)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.setTitle(self.titleLabel?.text?.capitalized, for: .normal)
        
        let btnGradient = CAGradientLayer()
        btnGradient.frame = self.bounds
        btnGradient.colors = [gradientColor1, gradientColor2]
        self.layer.insertSublayer(btnGradient, at: 0)
        
        self.contentEdgeInsets.bottom = 4

    } */
    

    
    
//    func setCustomAttributedTitle(title: String, fontSize: CGFloat){
//        let strokeTextAttributes = [
//            NSStrokeColorAttributeName : UIColor.black,
//            NSForegroundColorAttributeName : UIColor.white,
//            NSStrokeWidthAttributeName : -4.0,
//            NSFontAttributeName: UIFont(name: "EjaRoundFilled", size: fontSize)!
//            ] as [String : Any]
//        let attributedString = NSAttributedString(string: title, attributes: strokeTextAttributes)
//        self.setAttributedTitle(attributedString, for: .normal)
//    }

}
