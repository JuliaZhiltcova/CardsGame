//
//  Level.swift
//  Cards
//
//  Created by Admin on 04/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class Level{

    let numberOfLevel: Int
    let image: UIImage
    
   // let bestTime: Int     // in seconds
    
    
    init(numberOfLevel: Int, imageName: String) {
        self.numberOfLevel = numberOfLevel
        self.image = UIImage(named: imageName)!
    }

}
