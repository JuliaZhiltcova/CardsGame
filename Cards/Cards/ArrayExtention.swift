//
//  ArrayExtention.swift
//  Cards
//
//  Created by Admin on 08/02/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

extension Array{
    
    mutating func shuffled(){
        
        var temp = [Element]()
        
        for _  in self{
            
            /*Generating random number with length*/
            let random = arc4random_uniform(UInt32(self.count))
            /*Take the element from array*/
            let elementTaken = self[Int(random)]
            /*Append it to new tempArray*/
            temp.append(elementTaken)
            /*Remove the element from array*/
            self.remove(at: Int(random))
            
        }
        /* array = tempArray*/
        self = temp
    }
}

