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
    
    //let bestTime: TimeInterval     // in seconds
    
    
    init(numberOfLevel: Int, imageName: String) {
        self.numberOfLevel = numberOfLevel
        self.image = UIImage(named: imageName)!
    }
    
    lazy var currentGame: Game = Game(level: self.numberOfLevel)
    
    static var currentLevel: Int = 0
    
//
//    
//    private var currentGame_: Game?
//    
//    static func initGame(типИгры:Int, левел:Int) {
//        //
//        
//        var theCosOfZero: Double = Double(cos(0))  // theCosOfZero equals 1
//    }
//    
//    var currentGame: Game? {
//        get {
//            return currentGame_
//        }
//    }

}
