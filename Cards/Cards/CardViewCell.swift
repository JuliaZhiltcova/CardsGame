//
//  CardViewCell.swift
//  Cards
//
//  Created by Admin on 29/01/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImageView: UIImageView!

    @IBOutlet weak var backSideLayer: UIImageView!

  
   let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
    
   
    func flipCard(flipToFace direction : Bool) {   //true - open card

        let fromView = direction ? backSideLayer : cardImageView
        let toView = direction ? cardImageView : backSideLayer
        
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
        
        UIView.transition(from: fromView!, to: toView!, duration: 0.2, options: transitionOptions, completion: nil)
        
    }
    
    func flipOver(){
        
        UIView.transition(from: backSideLayer, to: cardImageView, duration: 3, options: transitionOptions) { success in
            UIView.transition(from: self.cardImageView, to: self.backSideLayer, duration: 3, options: self.transitionOptions)
        }
    }
}
    
/*    func flipCardToBack(){
            
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
            
        UIView.transition(from: cardImageView, to: backSideLayer, duration: 0.2, options: transitionOptions, completion:nil)
    }
    
    
    func flipCardToFace(){
        
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
        
        UIView.transition(from: backSideLayer, to: cardImageView, duration: 0.2, options: transitionOptions, completion: nil)
    }
    
    func flipOver(){
    
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
        UIView.transition(from: backSideLayer, to: cardImageView, duration: 2, options: transitionOptions) { success in
                UIView.transition(from: self.cardImageView, to: self.backSideLayer, duration: 2, options: transitionOptions)
        }

        
    } */
        /*
        UIView.transition(with: backSideLayer, duration: 0.2, options: transitionOptions, animations: {
            self.backSideLayer.isHidden = true  //спрятать зад
        })
        
        UIView.transition(with: cardImageView, duration: 0.2, options: transitionOptions, animations: {
            self.cardImageView.isHidden = false //открыть лицо
            
        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

            
            UIView.transition(with: self.cardImageView, duration: 0.2, options: transitionOptions, animations: {
                self.cardImageView.isHidden = true
            })
            
            UIView.transition(with: self.backSideLayer, duration: 0.2, options: transitionOptions, animations: {
                self.backSideLayer.isHidden = false
            })
            
        }
 
        
    }
 
*/
 

